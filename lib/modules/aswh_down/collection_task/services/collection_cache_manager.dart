import 'package:hive/hive.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

/// Hive 缓存管理：负责保存/恢复自动化仓库采集快照。
class OnlinePickCollectionCacheManager {
  static const String _boxName = 'aswh_down_collection_cache';

  Future<Box<OnlinePickCollectionCacheSnapshot>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<OnlinePickCollectionCacheSnapshot>(_boxName);
    }
    return Hive.openBox<OnlinePickCollectionCacheSnapshot>(_boxName);
  }

  Future<OnlinePickCollectionCacheSnapshot?> loadSnapshot(String taskId) async {
    final box = await _openBox();
    return box.get(taskId);
  }

  Future<void> saveSnapshot(
    String taskId,
    OnlinePickCollectionCacheSnapshot snapshot,
  ) async {
    final box = await _openBox();
    await box.put(taskId, snapshot);
  }

  Future<void> clearSnapshot(String taskId) async {
    if (!Hive.isBoxOpen(_boxName)) {
      return;
    }
    final box = Hive.box<OnlinePickCollectionCacheSnapshot>(_boxName);
    await box.delete(taskId);
  }
}
