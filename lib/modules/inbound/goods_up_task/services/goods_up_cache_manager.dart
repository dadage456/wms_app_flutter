import 'package:hive/hive.dart';

import '../models/goods_up_models.dart';

class GoodsUpCachedState {
  const GoodsUpCachedState({
    required this.detailList,
    required this.stocks,
    required this.dicSeq,
    required this.dicMtlQty,
  });

  final List<InTaskItem> detailList;
  final List<UpCollectionStock> stocks;
  final Map<String, String> dicSeq;
  final Map<String, List<double>> dicMtlQty;
}

/// 入库上架缓存管理器
class GoodsUpCacheManager {
  GoodsUpCacheManager(this.taskId);

  final int taskId;
  Box<dynamic>? _box;

  Future<Box<dynamic>> _openBox() async {
    final existing = _box;
    if (existing != null && existing.isOpen) {
      return existing;
    }
    _box = await Hive.openBox<dynamic>('goods_up_cache_$taskId');
    return _box!;
  }

  Future<void> cacheState({
    required List<InTaskItem> detailList,
    required List<UpCollectionStock> stocks,
    required Map<String, String> dicSeq,
    required Map<String, List<double>> dicMtlQty,
  }) async {
    final box = await _openBox();
    await box.put(
      'detailList',
      detailList.map((item) => item.toJson()).toList(),
    );
    await box.put('stocks', stocks.map((stock) => stock.toJson()).toList());
    await box.put('dicSeq', dicSeq);
    await box.put(
      'dicMtlQty',
      dicMtlQty.map(
        (key, value) => MapEntry(key, value.map((e) => e).toList()),
      ),
    );
    await box.put('updateFlag', '1');
  }

  Future<GoodsUpCachedState?> restoreState() async {
    final box = await _openBox();
    final updateFlag = box.get('updateFlag', defaultValue: '0').toString();
    if (updateFlag != '1') {
      return null;
    }

    final cachedDetailList = List<Map<String, dynamic>>.from(
      (box.get('detailList', defaultValue: <Map<String, dynamic>>[]) as List)
          .map((item) => Map<String, dynamic>.from(item as Map)),
    );
    final cachedStocks = List<Map<String, dynamic>>.from(
      (box.get('stocks', defaultValue: <Map<String, dynamic>>[]) as List).map(
        (item) => Map<String, dynamic>.from(item as Map),
      ),
    );
    final cachedDicSeq = Map<String, String>.from(
      (box.get('dicSeq', defaultValue: <String, String>{}) as Map).map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      ),
    );

    final dicMtlQtyRaw =
        (box.get('dicMtlQty', defaultValue: <String, dynamic>{}) as Map).map(
          (key, value) => MapEntry(key.toString(), value),
        );
    final dicMtlQty = dicMtlQtyRaw.map((key, value) {
      final list = (value as List?) ?? const [];
      return MapEntry(
        key,
        list.whereType<num>().map((e) => e.toDouble()).toList(growable: false),
      );
    });

    final detailList = cachedDetailList
        .map((item) => InTaskItem.fromJson(item))
        .toList(growable: false);

    final stocks = cachedStocks
        .map((item) => UpCollectionStock.fromJson(item))
        .toList(growable: false);

    return GoodsUpCachedState(
      detailList: detailList,
      stocks: stocks,
      dicSeq: cachedDicSeq,
      dicMtlQty: dicMtlQty,
    );
  }

  Future<void> clear() async {
    final box = await _openBox();
    await box.put('detailList', <Map<String, dynamic>>[]);
    await box.put('stocks', <Map<String, dynamic>>[]);
    await box.put('dicSeq', <String, String>{});
    await box.put('dicMtlQty', <String, List<double>>{});
    await box.put('updateFlag', '0');
  }
}
