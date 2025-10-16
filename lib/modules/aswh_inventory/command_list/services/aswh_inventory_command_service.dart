import 'package:dio/dio.dart';

import '../../../../services/api_response_handler.dart';
import '../models/inventory_command_models.dart';

/// 指令查询与撤销服务
class AswhInventoryCommandService {
  AswhInventoryCommandService(this._dio);

  final Dio _dio;

  Future<List<InventoryWcsCommand>> fetchCommands({
    required String taskComment,
    String? taskId,
    required String taskType,
    String? query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getWmsToWcsByTaskID',
      queryParameters: {
        'taskComment': taskComment,
        if (taskId != null) 'taskId': taskId,
        'TaskType': taskType,
        if (query != null && query.isNotEmpty) 'queryStr': query,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map(
                (item) => InventoryWcsCommand.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList();
        }
        throw Exception('指令列表返回格式异常');
      },
    );
  }

  Future<void> revokeCommand({
    required InventoryCommandAction action,
    required InventoryWcsCommand command,
    String? taskId,
    required String taskNo,
  }) async {
    final endpoint = switch (action) {
      InventoryCommandAction.revokeBack =>
        '/system/terminal/commitInvResetWmsToWcs',
      InventoryCommandAction.revokeOutbound =>
        '/system/terminal/commitInvDownWmsToWcs',
    };

    final response = await _dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: {
        'taskId': taskId ?? command.taskId ?? taskNo,
        'taskNo': taskNo,
        'trayNo': command.palletNo ?? '',
        'startAddr': command.startAddr ?? '',
        'endAddr': command.destAddr ?? '',
        'singleFlag': '1',
      },
    );

    ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data,
    );
  }
}
