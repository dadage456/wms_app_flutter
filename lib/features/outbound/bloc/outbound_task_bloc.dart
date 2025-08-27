import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/outbound_task.dart';
import '../services/outbound_task_service.dart';
import '../../../services/user_manager.dart';
import 'outbound_task_event.dart';
import 'outbound_task_state.dart';

/// 出库任务BLoC
class OutboundTaskBloc extends Bloc<OutboundTaskEvent, OutboundTaskState> {
  final OutboundTaskService _outboundTaskService;
  final UserManager _userManager;

  OutboundTaskBloc({
    required OutboundTaskService outboundTaskService,
    required UserManager userManager,
  }) : _outboundTaskService = outboundTaskService,
       _userManager = userManager,
       super(const OutboundTaskInitial()) {
    on<LoadOutboundTasksEvent>(_onLoadOutboundTasks);
    on<RefreshOutboundTasksEvent>(_onRefreshOutboundTasks);
    on<SearchOutboundTasksEvent>(_onSearchOutboundTasks);
    on<FilterOutboundTasksEvent>(_onFilterOutboundTasks);
    on<LoadPageEvent>(_onLoadPage);
    on<SortOutboundTasksEvent>(_onSortOutboundTasks);
  }

  /// 处理加载出库任务列表事件
  Future<void> _onLoadOutboundTasks(
    LoadOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    emit(const OutboundTaskLoading());

    try {
      final response = await _outboundTaskService.getOutboundTaskList(
        query: event.query,
      );

      if (response.code == '200') {
        emit(
          OutboundTaskLoaded(
            tasks: response.data.rows,
            total: response.data.total,
            currentPage: event.query.pageIndex,
            query: event.query,
            hasReachedMax: response.data.rows.length < event.query.pageSize,
          ),
        );
      } else {
        emit(OutboundTaskError(response.message));
      }
    } catch (e) {
      emit(OutboundTaskError(e.toString()));
    }
  }

  /// 处理刷新出库任务列表事件
  Future<void> _onRefreshOutboundTasks(
    RefreshOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final currentState = state;
    if (currentState is OutboundTaskLoaded) {
      emit(
        OutboundTaskRefreshing(
          tasks: currentState.tasks,
          total: currentState.total,
          currentPage: currentState.currentPage,
          query: currentState.query,
        ),
      );

      try {
        final refreshQuery = currentState.query.copyWith(pageIndex: 1);
        final response = await _outboundTaskService.getOutboundTaskList(
          query: refreshQuery,
        );

        if (response.code == '200') {
          emit(
            OutboundTaskLoaded(
              tasks: response.data.rows,
              total: response.data.total,
              currentPage: 1,
              query: refreshQuery,
              hasReachedMax: response.data.rows.length < refreshQuery.pageSize,
            ),
          );
        } else {
          emit(OutboundTaskError(response.message));
        }
      } catch (e) {
        emit(OutboundTaskError(e.toString()));
      }
    } else {
      // 如果当前状态不是已加载状态，则使用默认查询参数进行刷新
      final userInfo = _userManager.userInfo;
      if (userInfo != null) {
        final defaultQuery = OutboundTaskQuery(
          userId: userInfo.userId,
          roleOrUserId: userInfo.userId,
        );
        add(LoadOutboundTasksEvent(defaultQuery));
      }
    }
  }

  /// 处理搜索出库任务事件
  Future<void> _onSearchOutboundTasks(
    SearchOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final currentState = state;
    OutboundTaskQuery searchQuery;

    if (currentState is OutboundTaskLoaded) {
      searchQuery = currentState.query.copyWith(
        searchKey: event.searchKey,
        pageIndex: 1,
      );
    } else {
      final userInfo = _userManager.userInfo;
      if (userInfo == null) {
        emit(const OutboundTaskError('用户信息获取失败'));
        return;
      }
      searchQuery = OutboundTaskQuery(
        userId: userInfo.userId,
        roleOrUserId: userInfo.userId,
        searchKey: event.searchKey,
      );
    }

    add(LoadOutboundTasksEvent(searchQuery));
  }

  /// 处理筛选出库任务事件
  Future<void> _onFilterOutboundTasks(
    FilterOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final currentState = state;
    OutboundTaskQuery filterQuery;

    if (currentState is OutboundTaskLoaded) {
      filterQuery = currentState.query.copyWith(
        finishFlag: event.finishFlag,
        pageIndex: 1,
      );
    } else {
      final userInfo = _userManager.userInfo;
      if (userInfo == null) {
        emit(const OutboundTaskError('用户信息获取失败'));
        return;
      }
      filterQuery = OutboundTaskQuery(
        userId: userInfo.userId,
        roleOrUserId: userInfo.userId,
        finishFlag: event.finishFlag,
      );
    }

    add(LoadOutboundTasksEvent(filterQuery));
  }

  /// 处理分页加载事件
  Future<void> _onLoadPage(
    LoadPageEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final currentState = state;
    if (currentState is OutboundTaskLoaded) {
      emit(
        OutboundTaskPageLoading(
          tasks: currentState.tasks,
          total: currentState.total,
          currentPage: currentState.currentPage,
          query: currentState.query,
        ),
      );

      try {
        final pageQuery = currentState.query.copyWith(
          pageIndex: event.pageIndex,
        );
        final response = await _outboundTaskService.getOutboundTaskList(
          query: pageQuery,
        );

        if (response.code == '200') {
          emit(
            OutboundTaskLoaded(
              tasks: response.data.rows,
              total: response.data.total,
              currentPage: event.pageIndex,
              query: pageQuery,
              hasReachedMax: response.data.rows.length < pageQuery.pageSize,
            ),
          );
        } else {
          emit(OutboundTaskError(response.message));
        }
      } catch (e) {
        emit(OutboundTaskError(e.toString()));
      }
    }
  }

  /// 处理排序事件
  Future<void> _onSortOutboundTasks(
    SortOutboundTasksEvent event,
    Emitter<OutboundTaskState> emit,
  ) async {
    final currentState = state;
    OutboundTaskQuery sortQuery;

    if (currentState is OutboundTaskLoaded) {
      sortQuery = currentState.query.copyWith(
        sortColumn: event.sortColumn,
        sortType: event.sortType,
        pageIndex: 1,
      );
    } else {
      final userInfo = _userManager.userInfo;
      if (userInfo == null) {
        emit(const OutboundTaskError('用户信息获取失败'));
        return;
      }
      sortQuery = OutboundTaskQuery(
        userId: userInfo.userId,
        roleOrUserId: userInfo.userId,
        sortColumn: event.sortColumn,
        sortType: event.sortType,
      );
    }

    add(LoadOutboundTasksEvent(sortQuery));
  }

  /// 获取默认查询参数
  OutboundTaskQuery? getDefaultQuery() {
    final userInfo = _userManager.userInfo;
    if (userInfo == null) return null;

    return OutboundTaskQuery(
      userId: userInfo.userId,
      roleOrUserId: userInfo.userId,
    );
  }
}
