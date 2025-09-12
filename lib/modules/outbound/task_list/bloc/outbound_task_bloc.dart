import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import '../models/outbound_task.dart';
import '../../services/outbound_task_service.dart';
import '../../../../services/user_manager.dart';
import '../../../../common_widgets/common_grid/grid_bloc.dart';
import 'outbound_task_event.dart';
import 'outbound_task_state.dart';

/// 出库任务BLoC - 协助CommonDataGridBloc进行数据管理
class OutboundTaskBloc extends Bloc<OutboundTaskEvent, OutboundTaskState> {
  final OutboundTaskService outboundTaskService;
  final UserManager userManager;

  // 当前查询参数
  late OutboundTaskQuery currentQuery = getDefaultQuery();

  // 表格bloc
  late final gridBloc = CommonDataGridBloc(dataLoader: createDataLoader());

  OutboundTaskBloc({
    required this.outboundTaskService,
    required this.userManager,
  }) : super(const OutboundTaskState()) {
    on<SearchOutboundTasksEvent>(_onSearchOutboundTasks);
    on<FilterOutboundTasksEvent>(_onFilterOutboundTasks);
    on<RefrenshOutboundTasksEvent>(_onRefrenshOutboundTasks);
  }

  /// 创建数据加载器函数，供CommonDataGridBloc使用
  DataLoader<OutboundTask> createDataLoader() {
    return (int pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final data = await outboundTaskService.getOutboundTaskList(query: query);

      // 计算总页数
      final totalPages = (data.total / query.pageSize).ceil();

      return DataGridResponseData<OutboundTask>(
        totalPages: totalPages,
        data: data.rows,
      );
    };
  }

  /// 处理搜索出库任务事件
  Future<void> _onSearchOutboundTasks(
    SearchOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 0,
    );
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  /// 处理筛选出库任务事件
  Future<void> _onFilterOutboundTasks(
    FilterOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      finishFlag: event.finishFlag,
      pageIndex: 0,
    );

    final completer = Completer<DataGridResponseData<OutboundTask>>();

    gridBloc.add(LoadDataEvent(currentQuery.pageIndex, completer: completer));

    try {
      final response = await completer.future;
      debugPrint('${response.data.length}条数据加载完成');
    } catch (e) {
      debugPrint('数据加载失败: $e');
    }
  }

  /// 刷新出库任务
  Future<void> _onRefrenshOutboundTasks(
    RefrenshOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(0));
  }

  /// 获取默认查询参数
  OutboundTaskQuery getDefaultQuery() {
    final userInfo = Modular.get<UserManager>().userInfo!;

    return OutboundTaskQuery(
      userId: "${userInfo.userId}",
      roleOrUserId: "${userInfo.userId}",
      pageSize: 1000,
    );
  }
}
