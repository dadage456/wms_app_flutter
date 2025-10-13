import 'package:dio/dio.dart';

import '../models/goods_up_collection_task.dart';

class GoodsUpCollectionService {
  GoodsUpCollectionService(this._dio);

  final Dio _dio;

  Future<List<GoodsUpCollectionTask>> fetchPendingTasks({int? userId}) async {
    // TODO: 接入真实的入库上架任务列表接口
    return Future<List<GoodsUpCollectionTask>>.value(const []);
  }
}
