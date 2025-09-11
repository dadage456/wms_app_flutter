import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/utils/error_handler.dart';
import '../../services/outbound_task_service.dart';
import '../models/outbound_task_item.dart';
import 'outbound_task_detail_event.dart';
import 'outbound_task_detail_state.dart';

/// 出库任务明细BLoC
class OutboundTaskDetailBloc
    extends Bloc<OutboundTaskDetailEvent, OutboundTaskDetailState> {
  final OutboundTaskService _outboundTaskService;

  OutboundTaskDetailBloc(this._outboundTaskService)
    : super(const OutboundTaskDetailState.initial()) {
    log('OutboundTaskDetailBloc initialized');

    on<LoadTaskItemsEvent>(_onLoadTaskItems);
    on<SearchTaskItemsEvent>(_onSearchTaskItems);
    on<ScanQRCodeEvent>(_onScanQRCode);
    on<SelectTaskItemEvent>(_onSelectTaskItem);
    on<SelectAllEvent>(_onSelectAll);
    on<CancelSelectedItemsEvent>(_onCancelSelectedItems);
    on<ClearSelectionEvent>(_onClearSelection);
    on<RefreshEvent>(_onRefresh);
    on<LoadMoreEvent>(_onLoadMore);
  }

  /// 处理加载任务明细列表事件
  Future<void> _onLoadTaskItems(
    LoadTaskItemsEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    try {
      log('Loading task items with query: ${event.query.toJson()}');
      emit(const OutboundTaskDetailState.loading());

      final data = await _outboundTaskService.getOutboundTaskItemList(
        query: event.query,
      );

      log('Task items loaded successfully: ${data.rows.length} items');

      final taskItems = data.rows;
      final totalCount = data.total;
      final hasMore =
          taskItems.length < totalCount &&
          event.query.pageIndex * event.query.pageSize < totalCount;

      emit(
        OutboundTaskDetailState.loaded(
          taskItems: taskItems,
          selectedItemIds: <String>{},
          hasMore: hasMore,
          currentPage: event.query.pageIndex,
          totalCount: totalCount,
          currentQuery: event.query,
        ),
      );
    } catch (e) {
      log('Failed to load task items: $e');

      emit(OutboundTaskDetailState.error(message: ErrorHandler.handleError(e)));
    }
  }

  /// 处理搜索任务明细事件
  Future<void> _onSearchTaskItems(
    SearchTaskItemsEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    try {
      log('Searching task items with query: ${event.query.toJson()}');
      emit(const OutboundTaskDetailState.loading());

      final data = await _outboundTaskService.getOutboundTaskItemList(
        query: event.query,
      );

      log('Task items search completed: ${data.rows.length} items');

      final taskItems = data.rows;
      final totalCount = data.total;
      final hasMore =
          taskItems.length < totalCount &&
          event.query.pageIndex * event.query.pageSize < totalCount;

      emit(
        OutboundTaskDetailState.loaded(
          taskItems: taskItems,
          selectedItemIds: <String>{},
          hasMore: hasMore,
          currentPage: event.query.pageIndex,
          totalCount: totalCount,
          currentQuery: event.query,
        ),
      );
    } catch (e) {
      log('Failed to search task items: $e');
      emit(OutboundTaskDetailState.error(message: ErrorHandler.handleError(e)));
    }
  }

  /// 处理扫码事件
  Future<void> _onScanQRCode(
    ScanQRCodeEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    try {
      log('Scanning QR code: ${event.qrContent}');
      emit(const OutboundTaskDetailState.scanning());

      // 首先尝试解析二维码内容
      final materialCode = _outboundTaskService.parseQRContent(event.qrContent);

      if (materialCode != null) {
        // 如果能直接解析出物料编码，则直接搜索
        log('Parsed material code from QR: $materialCode');

        final currentState = state;
        final currentQuery = currentState.currentQuery;

        if (currentQuery != null) {
          final searchQuery = currentQuery.copyWith(
            searchKey: materialCode,
            pageIndex: 1, // 重置到第一页
          );

          add(OutboundTaskDetailEvent.searchTaskItems(query: searchQuery));
        }
      } else {
        // 如果无法直接解析，调用API获取物料信息
        log('Calling API to get material info for QR: ${event.qrContent}');

        final response = await _outboundTaskService.getMaterialInfoByQR(
          event.qrContent,
        );

        log('Material info retrieved: ${response.data.matCode}');

        await state.when(
          initial: () async {},
          loading: () async {},
          loaded:
              (
                taskItems,
                selectedItemIds,
                hasMore,
                currentPage,
                totalCount,
                currentQuery,
                scannedMaterial,
              ) async {
                if (currentQuery != null) {
                  final searchQuery = currentQuery.copyWith(
                    searchKey: response.data.matCode,
                    pageIndex: 1, // 重置到第一页
                  );

                  emit(
                    OutboundTaskDetailState.loaded(
                      taskItems: taskItems,
                      selectedItemIds: selectedItemIds,
                      hasMore: hasMore,
                      currentPage: currentPage,
                      totalCount: totalCount,
                      currentQuery: currentQuery,
                      scannedMaterial: response.data,
                    ),
                  );

                  add(
                    OutboundTaskDetailEvent.searchTaskItems(query: searchQuery),
                  );
                }
              },
          error: (_, __, ___) async {},
          scanning: () async {},
          cancelling: (_, __) async {},
        );
      }
    } catch (e) {
      log('Failed to scan QR code: $e');
      emit(
        OutboundTaskDetailState.error(
          message: e.toString(),
          taskItems: state.taskItems,
          selectedItemIds: state.selectedItemIds,
        ),
      );
    }
  }

  /// 处理选择任务明细项事件
  void _onSelectTaskItem(
    SelectTaskItemEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) {
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            final newSelectedItemIds = Set<String>.from(selectedItemIds);

            if (event.isSelected) {
              newSelectedItemIds.add(event.taskItemId);
            } else {
              newSelectedItemIds.remove(event.taskItemId);
            }

            log(
              'Task item ${event.taskItemId} ${event.isSelected ? 'selected' : 'deselected'}. Total selected: ${newSelectedItemIds.length}',
            );

            emit(
              OutboundTaskDetailState.loaded(
                taskItems: taskItems,
                selectedItemIds: newSelectedItemIds,
                hasMore: hasMore,
                currentPage: currentPage,
                totalCount: totalCount,
                currentQuery: currentQuery,
                scannedMaterial: scannedMaterial,
              ),
            );
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 处理全选/取消全选事件
  void _onSelectAll(
    SelectAllEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) {
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            final newSelectedItemIds = event.isSelectAll
                ? taskItems.map((item) => item.outTaskItemId.toString()).toSet()
                : <String>{};

            log(
              '${event.isSelectAll ? 'Select all' : 'Deselect all'} items. Total selected: ${newSelectedItemIds.length}',
            );

            emit(
              OutboundTaskDetailState.loaded(
                taskItems: taskItems,
                selectedItemIds: newSelectedItemIds,
                hasMore: hasMore,
                currentPage: currentPage,
                totalCount: totalCount,
                currentQuery: currentQuery,
                scannedMaterial: scannedMaterial,
              ),
            );
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 处理撤销选中项事件
  Future<void> _onCancelSelectedItems(
    CancelSelectedItemsEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    await state.when(
      initial: () async {},
      loading: () async {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) async {
            if (selectedItemIds.isEmpty) return;

            try {
              log('取消界面上的选中的项: ${selectedItemIds.toList()}');
              emit(
                OutboundTaskDetailState.cancelling(
                  taskItems: taskItems,
                  selectedItemIds: selectedItemIds,
                ),
              );

              log('请求取消任务: ${selectedItemIds.toList()}');
              await _outboundTaskService.cancelOutboundTaskItems(
                taskItemIds: selectedItemIds.toList(),
              );

              // 撤销成功后刷新列表
              if (currentQuery != null) {
                add(OutboundTaskDetailEvent.loadTaskItems(query: currentQuery));
              }
            } catch (e) {
              log('Failed to cancel selected items: $e');
              emit(
                OutboundTaskDetailState.error(
                  message: ErrorHandler.handleError(e),
                  taskItems: taskItems,
                  selectedItemIds: selectedItemIds,
                ),
              );
            }
          },
      error: (_, __, ___) async {},
      scanning: () async {},
      cancelling: (_, __) async {},
    );
  }

  /// 处理清除选择状态事件
  void _onClearSelection(
    ClearSelectionEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) {
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            log('Clearing selection');
            emit(
              OutboundTaskDetailState.loaded(
                taskItems: taskItems,
                selectedItemIds: <String>{},
                hasMore: hasMore,
                currentPage: currentPage,
                totalCount: totalCount,
                currentQuery: currentQuery,
                scannedMaterial: scannedMaterial,
              ),
            );
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 处理刷新事件
  void _onRefresh(RefreshEvent event, Emitter<OutboundTaskDetailState> emit) {
    final currentState = state;
    if (currentState.currentQuery != null) {
      log('Refreshing task items');
      add(
        OutboundTaskDetailEvent.loadTaskItems(
          query: currentState.currentQuery!.copyWith(pageIndex: 1),
        ),
      );
    }
  }

  /// 处理加载更多事件
  void _onLoadMore(LoadMoreEvent event, Emitter<OutboundTaskDetailState> emit) {
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            if (!hasMore || currentQuery == null) return;

            log('Loading more task items');
            final nextPageQuery = currentQuery.copyWith(
              pageIndex: currentPage + 1,
            );

            _loadMoreTaskItems(nextPageQuery, emit);
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 加载更多任务明细（追加到现有列表）
  Future<void> _loadMoreTaskItems(
    OutboundTaskItemQuery query,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    await state.when(
      initial: () async {},
      loading: () async {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) async {
            try {
              log('Loading more task items with query: ${query.toJson()}');

              final data = await _outboundTaskService.getOutboundTaskItemList(
                query: query,
              );

              log('More task items loaded: ${data.rows.length} items');

              final newTaskItems = data.rows;
              final allTaskItems = [...taskItems, ...newTaskItems];
              final newTotalCount = data.total;
              final newHasMore = allTaskItems.length < newTotalCount;

              emit(
                OutboundTaskDetailState.loaded(
                  taskItems: allTaskItems,
                  selectedItemIds: selectedItemIds,
                  hasMore: newHasMore,
                  currentPage: query.pageIndex,
                  totalCount: newTotalCount,
                  currentQuery: query,
                  scannedMaterial: scannedMaterial,
                ),
              );
            } catch (e) {
              log('Failed to load more task items: $e');
              emit(
                OutboundTaskDetailState.error(
                  message: ErrorHandler.handleError(e),
                  taskItems: taskItems,
                  selectedItemIds: selectedItemIds,
                ),
              );
            }
          },
      error: (_, __, ___) async {},
      scanning: () async {},
      cancelling: (_, __) async {},
    );
  }

  /// 获取默认查询参数
  OutboundTaskItemQuery getDefaultQuery(
    String outTaskId,
    String workStation,
    int userId,
    int roleOrUserId,
  ) {
    return OutboundTaskItemQuery(
      outTaskId: outTaskId,
      workStation: workStation,
      userId: userId,
      roleOrUserId: roleOrUserId,
      pageIndex: 1,
      pageSize: 20,
    );
  }
}
