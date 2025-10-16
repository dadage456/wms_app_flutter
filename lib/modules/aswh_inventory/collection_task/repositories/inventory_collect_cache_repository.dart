import 'package:hive/hive.dart';

import '../models/inventory_collect_models.dart';

class InventoryCollectCacheRepository {
  InventoryCollectCacheRepository({HiveInterface? hive}) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  Box<dynamic>? _cacheBox;
  String? _cacheKey;

  bool get isReady => _cacheBox != null;

  Future<void> initialize(String taskKey) async {
    if (_cacheKey == taskKey && _cacheBox != null) {
      return;
    }

    await _cacheBox?.close();
    _cacheKey = taskKey;
    _cacheBox = await _hive.openBox<dynamic>('aswh_inventory_collect_\$taskKey');
  }

  Future<void> persistSnapshot(InventoryCollectStateSnapshot snapshot) async {
    if (_cacheBox == null) return;

    await _cacheBox!.put('snapshot', snapshot.toJson());
  }

  Future<InventoryCollectStateSnapshot?> readSnapshot() async {
    if (_cacheBox == null) return null;

    final snapshot = _cacheBox!.get('snapshot');
    if (snapshot == null) return null;

    return InventoryCollectStateSnapshot.fromJson(
      Map<String, dynamic>.from(snapshot as Map),
    );
  }

  Future<void> clear() async {
    await _cacheBox?.clear();
  }

  Future<void> dispose() async {
    await _cacheBox?.close();
    _cacheBox = null;
    _cacheKey = null;
  }
}
