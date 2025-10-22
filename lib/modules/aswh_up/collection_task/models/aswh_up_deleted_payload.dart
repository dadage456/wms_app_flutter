import '../../models/aswh_up_collection_models.dart';

/// ASWH上架采集删除的库存数据payload
class AswhUpDeletedStocksPayload {
  /// 已删除的库存记录列表
  final List<AswhUpCollectionStock> deletedStocks;

  AswhUpDeletedStocksPayload(this.deletedStocks);

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'deletedStocks': deletedStocks.map((stock) => stock.toJson()).toList(),
    };
  }

  /// 从JSON创建
  factory AswhUpDeletedStocksPayload.fromJson(Map<String, dynamic> json) {
    final deletedStocksList = json['deletedStocks'] as List<dynamic>?;
    final stocks = deletedStocksList
            ?.map((item) => AswhUpCollectionStock.fromJson(item as Map<String, dynamic>))
            .toList() ??
        [];

    return AswhUpDeletedStocksPayload(stocks);
  }

  /// 获取删除数量
  int get deletedCount => deletedStocks.length;

  @override
  String toString() {
    return 'AswhUpDeletedStocksPayload{deletedCount: $deletedCount}';
  }
}