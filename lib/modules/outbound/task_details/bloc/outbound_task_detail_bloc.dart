import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/utils/error_handler.dart';
import '../../services/outbound_task_service.dart';
import '../../../../services/user_manager.dart';
import '../models/outbound_task_item.dart';
import 'outbound_task_detail_event.dart';
import 'outbound_task_detail_state.dart';

/// 出库任务明细BLoC
class OutboundTaskDetailBloc
    extends Bloc<OutboundTaskDetailEvent, OutboundTaskDetailState> {
  final OutboundTaskService _outboundTaskService;
  final UserManager _userManager;

  OutboundTaskDetailBloc(this._outboundTaskService, this._userManager)
    : super(OutboundTaskDetailState()) {
    log('OutboundTaskDetailBloc initialized');

    on<SearchEvent>(_onSearch);
    on<ScanQRCodeEvent>(_onScanQRCode);
    on<CancelSelectedItemsEvent>(_onCancelSelectedItems);
    on<RefreshEvent>(_onRefresh);

    // 初始化表格BLoC
    _initializeGridBloc();
  }

  late final CommonDataGridBloc<OutboundTaskItem> gridBloc;
  late OutboundTaskItemQuery currentQuery;

  /// 初始化表格BLoC
  void _initializeGridBloc() {
    gridBloc = CommonDataGridBloc<OutboundTaskItem>(
      dataLoader: createDataLoader(),
      dataDeleter: createDataDeleter(),
    );
  }

  /// 创建数据加载器
  DataGridLoader<OutboundTaskItem> createDataLoader() {
    return (int pageIndex) async {
      currentQuery = currentQuery.copyWith(pageIndex: pageIndex);
      final data = await _outboundTaskService.getOutboundTaskItemList(
        query: currentQuery,
      );
      final totalPages = (data.total / currentQuery.pageSize).ceil();

      return DataGridResponseData<OutboundTaskItem>(
        totalPages: totalPages,
        data: data.rows,
      );
    };
  }

  /// 创建数据删除器
  DataGridDeleter createDataDeleter() {
    return (indexs) async {
      final datas = gridBloc.state.data;
      final ids = indexs.map((i) => datas[i].outTaskItemId.toString()).toList();
      await _outboundTaskService.cancelOutboundTaskItems(taskItemIds: ids);
      gridBloc.add(RefrenshLoadDataEvent());
    };
  }

  /// 初始化查询参数
  void initializeQuery(String outTaskId, String workStation) {
    final userInfo = _userManager.userInfo;
    if (userInfo != null) {
      currentQuery = OutboundTaskItemQuery(
        outTaskId: outTaskId,
        workStation: workStation,
        userId: userInfo.userId,
        roleOrUserId: userInfo.userId,
        pageIndex: 1,
        pageSize: 100,
      );
    }
  }

  /// 处理搜索事件
  Future<void> _onSearch(
    SearchEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    // 通知表格BLoC重新加载数据
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  /// 处理扫码事件
  Future<void> _onScanQRCode(
    ScanQRCodeEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    try {
      log('Scanning QR code: ${event.qrContent}');
      // emit(state.copyWith(isLoading: true));

      // 首先尝试解析二维码内容
      final materialCode = _outboundTaskService.parseQRContent(event.qrContent);

      if (materialCode != null) {
        // 如果能直接解析出物料编码，则直接搜索
        log('Parsed material code from QR: $materialCode');
        add(SearchEvent(searchKey: materialCode));
      } else {
        // 如果无法直接解析，调用API获取物料信息
        log('Calling API to get material info for QR: ${event.qrContent}');

        final response = await _outboundTaskService.getMaterialInfoByQR(
          event.qrContent,
        );

        log('Material info retrieved: ${response.data.matCode}');

        // 使用解析出的物料编码进行搜索
        add(SearchEvent(searchKey: response.data.matCode));
      }
    } catch (e) {
      log('Failed to scan QR code: $e');
      // emit(
      //   state.copyWith(
      //     isLoading: false,
      //     errorMessage: ErrorHandler.handleError(e),
      //   ),
      // );
    }
  }

  /// 处理撤销选中项事件
  Future<void> _onCancelSelectedItems(
    CancelSelectedItemsEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    gridBloc.add(DeleteSelectedRowsEvent(event.selectedRows));
  }

  /// 处理刷新事件
  Future<void> _onRefresh(
    RefreshEvent event,
    Emitter<OutboundTaskDetailState> emit,
  ) async {
    try {
      log('Refreshing task items');
      // emit(state.copyWith(isLoading: true));

      // 通知表格BLoC重新加载数据
      gridBloc.add(LoadDataEvent(currentQuery.pageIndex));

      // emit(state.copyWith(isLoading: false));
    } catch (e) {
      log('Failed to refresh: $e');
      // emit(
      // state.copyWith(
      //   isLoading: false,
      //   errorMessage: ErrorHandler.handleError(e),
      // ),
      // );
    }
  }
}
