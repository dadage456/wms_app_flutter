import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/inventory_collect_models.dart';

/// 管理盘点采集本地缓存
class InventoryCollectCacheRepository {
  InventoryCollectCacheRepository(this._hive);

  final HiveInterface _hive;

  Box<String>? _cacheBox;

  Future<void> init(String taskKey) async {
    final boxName = 'inventory_collect_\$taskKey';
    _cacheBox = await _hive.openBox<String>(boxName);
  }

  Future<void> dispose() async {
    await _cacheBox?.close();
    _cacheBox = null;
  }

  Future<List<InventoryCollectRecord>> loadRecords() async {
    final data = _cacheBox?.values.toList() ?? const [];
    if (data.isEmpty) {
      return const [];
    }
    return data
        .map((jsonStr) => InventoryCollectRecord.fromJson(
              json.decode(jsonStr) as Map<String, dynamic>,
            ))
        .toList();
  }

  Future<void> saveRecords(List<InventoryCollectRecord> records) async {
    final box = _cacheBox;
    if (box == null) {
      throw StateError('InventoryCollectCacheRepository 尚未初始化');
    }
    await box.clear();
    if (records.isEmpty) {
      return;
    }
    final entries = records
        .map((record) => json.encode(record.toJson()))
        .toList(growable: false);
    await box.addAll(entries);
  }

  Future<void> removeRecord(InventoryCollectRecord record) async {
    final box = _cacheBox;
    if (box == null) {
      throw StateError('InventoryCollectCacheRepository 尚未初始化');
    }
    dynamic matchedKey;
    for (final key in box.keys) {
      final value = box.get(key) as String?;
      if (value == null) {
        continue;
      }
      final jsonMap = json.decode(value) as Map<String, dynamic>;
      final sameItem = jsonMap['itemid']?.toString() == record.itemId &&
          jsonMap['storesiteno']?.toString() == record.storeSiteNo &&
          jsonMap['matcode']?.toString() == record.materialCode;
      if (sameItem) {
        matchedKey = key;
        break;
      }
    }
    if (matchedKey != null) {
      await box.delete(matchedKey);
    }
  }
}
