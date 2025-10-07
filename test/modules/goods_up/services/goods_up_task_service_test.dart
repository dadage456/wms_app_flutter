import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';

class RecordingDio extends Dio {
  RecordingDio({this.responseData});

  dynamic responseData;
  String? lastPath;
  Map<String, dynamic>? lastQueryParameters;
  dynamic lastData;
  Options? lastOptions;

  void queueResponse(dynamic data) {
    responseData = data;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastPath = path;
    lastQueryParameters = queryParameters;
    final data = responseData as T?;
    return Response<T>(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastPath = path;
    lastData = data;
    lastQueryParameters = queryParameters;
    lastOptions = options;
    final response = responseData as T?;
    return Response<T>(
      data: response,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }
}

void main() {
  group('GoodsUpTaskService', () {
    late RecordingDio dio;
    late GoodsUpTaskService service;

    setUp(() {
      dio = RecordingDio(
        responseData: {
          'code': 200,
          'msg': 'success',
          'data': {
            'total': 0,
            'rows': <Map<String, dynamic>>[],
          },
        },
      );
      service = GoodsUpTaskService(dio);
    });

    test('getInboundTaskList passes query parameters to Dio', () async {
      final query = GoodsUpTaskQuery(
        userId: '1',
        roleOrUserId: '1',
        pageIndex: 2,
        pageSize: 50,
      );

      await service.getInboundTaskList(query: query);

      expect(dio.lastPath, '/system/terminal/intaskList');
      expect(dio.lastQueryParameters, equals(query.toJson()));
    });

    test('commitInboundTaskItems sends correct payload', () async {
      dio.queueResponse({'code': 200, 'msg': 'ok', 'data': {}});

      await service.commitInboundTaskItems(
        inTaskItemIds: const [1, 2, 3],
        roomTag: '0',
        isCancel: false,
      );

      expect(dio.lastPath, '/system/terminal/commitRCInTaskItem');
      expect(dio.lastData, {
        'intaskitemids': const [1, 2, 3],
        'roomTag': '0',
        'isCanel': 'false',
      });
      expect(
        dio.lastOptions?.headers?['content-type'],
        'application/json;charset=UTF-8',
      );
    });
  });
}
