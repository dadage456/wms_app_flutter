import 'package:hive/hive.dart';

import '../models/arrival_collect_cache.dart';

class ArrivalCollectCacheRepository {
  ArrivalCollectCacheRepository({HiveInterface? hive}) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  static const String _boxName = 'arrival_collect_cache';

  Future<Box<Map>> _openBox() async {
    if (_hive.isBoxOpen(_boxName)) {
      return _hive.box<Map>(_boxName);
    }
    return _hive.openBox<Map>(_boxName);
  }

  Future<void> saveCache({
    required String key,
    required ArrivalCollectCache cache,
  }) async {
    final box = await _openBox();
    await box.put(key, cache.toJson());
  }

  Future<ArrivalCollectCache?> loadCache(String key) async {
    final box = await _openBox();
    final data = box.get(key);
    if (data == null) {
      return null;
    }
    return ArrivalCollectCache.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> clearCache(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }
}
