import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  OutboundTaskQuery? _currentQuery;

  OutboundTaskBloc({required this.outboundTaskService, required this.userManager})
      : super(const OutboundTaskInitial()) {
    on<SearchOutboundTasksEvent>(_onSearchOutboundTasks);
    on<FilterOutboundTasksEvent>(_onFilterOutboundTasks);
  }

  /// 创建数据加载器函数，供CommonDataGridBloc使用
  DataLoader<OutboundTask> createDataLoader() {
    return (int pageIndex) async {
      final query = _currentQuery?.copyWith(pageIndex: pageIndex) ?? getDefaultQuery()!.copyWith(pageIndex: pageIndex);
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
    final userInfo = userManager.userInfo;
    if (userInfo == null) {
      emit(const OutboundTaskError('用户信息获取失败'));
      return;
    }

    _currentQuery = (_currentQuery ?? getDefaultQuery()!).copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    emit(OutboundTaskQueryUpdated(_currentQuery!));
  }

  /// 处理筛选出库任务事件
  Future<void> _onFilterOutboundTasks(
    FilterOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final userInfo = userManager.userInfo;
    if (userInfo == null) {
      emit(const OutboundTaskError('用户信息获取失败'));
      return;
    }

    _currentQuery = (_currentQuery ?? getDefaultQuery()!).copyWith(
      finishFlag: event.finishFlag,
      pageIndex: 1,
    );

    emit(OutboundTaskQueryUpdated(_currentQuery!));
  }

  /// 获取默认查询参数
  OutboundTaskQuery? getDefaultQuery() {
    final userInfo = Modular.get<UserManager>().userInfo;
    if (userInfo == null) return null;

    return OutboundTaskQuery(
      userId: "${userInfo.userId}",
      roleOrUserId: "${userInfo.userId}",
      pageSize: 1000,
    );
  }
}
