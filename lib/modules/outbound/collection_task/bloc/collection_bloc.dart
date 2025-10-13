import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/common/collection/base_collection_bloc.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_request.dart';
import 'package:wms_app/modules/outbound/collection_task/services/collection_service.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/utils/custom_extension.dart';
import 'package:wms_app/utils/error_handler.dart';

import 'collection_event.dart';

class CollectionBloc extends BaseCollectionBloc<OutboundTask> {
  final CollectionService _service;
  late OutboundTask _task;

  CollectionBloc(this._service) : super() {
    on<InitializeTaskEvent>(_onInitializeTask);
    on<CommitCollectionEvent>(_onCommitCollection);
    on<ReportShortageEvent>(_onReportShortage);
  }

  Future<void> _onInitializeTask(
    InitializeTaskEvent event,
    Emitter<CollectionState> emit,
  ) async {
    _task = event.task;
    configureTask(
      userId: event.userId,
      taskId: _task.outTaskId.toString(),
      taskNo: _task.outTaskNo,
      storeRoomNo: _task.storeRoomNo,
    );

    await openCache('collection_cache_${_task.outTaskId}');
    await clearCache();
    await loadTaskList(emit);
    await restoreFromCache(emit);
  }

  Future<void> loadTaskList(Emitter<CollectionState> emit) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final detailList = await _service.getOutTaskCollitemList(
        CollectionTaskItemQuery(
          outTaskNo: _task.outTaskNo,
          storeRoomNo: _task.storeRoomNo,
          forceSite: '',
          forceBatch: '',
          taskComment: _task.taskComment,
          taskFinishFlag: '0',
          roomTag: '0',
          workStation: _task.workStation,
          finishFlag: '0',
          sortType: '',
          sortColumn: '',
          searchKey: '',
          beatFlag: 'N',
          collecter: userId,
        ),
      );

      if (detailList.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('当前任务列表没有待处理任务')));
        return;
      }

      String roomMatControl = '0';
      final controlResponse = await _service.getRoomMatControl(
        _task.outTaskId.toString(),
      );
      final roomMtlInfo = controlResponse.split('!');
      if (roomMtlInfo.length > 4 && roomMtlInfo[4].isNotEmpty) {
        roomMatControl = roomMtlInfo[4];
      }

      MtlCheckMode mtlCheckMode;
      if (siteFlag == 'Y' && batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlSiteBatch;
      } else if (siteFlag == 'Y' && batchFlag != 'Y') {
        mtlCheckMode = MtlCheckMode.mtlSite;
      } else if (siteFlag != 'Y' && batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlBatch;
      } else {
        mtlCheckMode = MtlCheckMode.mtl;
      }

      emit(
        state.copyWith(
          detailList: detailList,
          status: CollectionStatus.success(),
          roomMatControl: roomMatControl,
          mtlCheckMode: mtlCheckMode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(e)),
        ),
      );
    }
  }

  Future<void> _onCommitCollection(
    CommitCollectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (state.stocks.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('本次无采集明细，请确认！')));
        return;
      }

      String msg = '';
      String tmpStore = '';
      String tmpMat = '';
      double taskQty1 = 0;
      double tmpQty1 = 0;

      for (final item in state.detailList) {
        tmpMat = item.matcode ?? '';
        tmpStore = item.storesiteno ?? '';
        taskQty1 = item.hintqty;
        tmpQty1 = item.collectedqty;

        if (taskQty1 != tmpQty1) {
          msg = '库位【$tmpStore】物料【$tmpMat】还剩【${taskQty1 - tmpQty1}】未做';
          break;
        }
      }

      if (msg.isNotEmpty) {
        msg += '，请确认是否提交？';
      } else {
        msg = '请确认是否提交？';
      }

      await _performCommit(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '平库出库采集异常：${ErrorHandler.handleError(e)}',
          ),
        ),
      );
    }
  }

  Future<void> _performCommit(Emitter<CollectionState> emit) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final collectStocks = state.stocks;
      if (collectStocks.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      final downShelvesInfosList = collectStocks
          .map(
            (stock) => {
              'taskNo': _task.outTaskNo,
              'matCode': stock.matcode,
              'batchNo': stock.batchno,
              'sn': stock.sn,
              'taskQty': stock.taskQty,
              'collectQty': stock.collectQty,
              'storeRoomNo': stock.storeRoom,
              'storeSiteNo': stock.storeSite,
              'taskid': stock.taskid,
              'outTaskItemid': stock.outtaskitemid,
              'erpStore': stock.erpStore,
            },
          )
          .toList();

      final lsItems = <Map<String, dynamic>>[];
      for (final entry in state.dicMtlQty.entries) {
        final itemListInfo = <String, dynamic>{};
        final mtlQty = entry.value.map((e) => e.toFormatString()).toList();
        itemListInfo['mtlQty'] = mtlQty;
        itemListInfo['outTaskItemid'] = entry.key;

        final taskItem = state.detailList.firstWhere(
          (item) => item.outtaskitemid.toString() == entry.key,
          orElse: () => OutTaskItem(
            outtaskitemid: 0,
            matcode: '',
            matname: '',
            storesiteno: '',
            hintqty: 0,
            collectedqty: 0,
            repqty: 0,
            hintbatchno: '',
            sn: '',
            storeroomno: '',
            subinventoryCode: '',
            orderno: '',
            matinnercode: '',
          ),
        );
        itemListInfo['mtlCode'] = taskItem.matcode;

        lsItems.add(itemListInfo);
      }

      if (lsItems.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      log('下架信息：$downShelvesInfosList');
      log('任务项信息：$lsItems');

      final response = await _service.commitDownShelves(
        downShelvesInfosList,
        lsItems,
      );

      if (response['code'] == 200) {
        await clearCache();
        emit(
          state.copyWith(
            status: CollectionStatus.success(response['msg'] ?? '提交成功'),
            stocks: [],
            dicSeq: {},
            dicMtlQty: {},
            dicInvMtlQty: {},
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CollectionStatus.error(response['msg'] ?? '提交失败'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '平库出库采集异常：${ErrorHandler.handleError(e)}',
          ),
        ),
      );
    }
  }

  Future<void> _onReportShortage(
    ReportShortageEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (state.stocks.isNotEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('采集数据未提交,不允许报缺！')));
        return;
      }

      if (state.checkedIds.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请至少选择一行记录！')));
        return;
      }
      final id = state.checkedIds.first;
      final response = await _service.commitFinishOutTaskItem(id);

      if (response['code'] == 200) {
        await loadTaskList(emit);
      } else {
        emit(
          state.copyWith(
            status: CollectionStatus.error(response['msg'] ?? '报缺失败'),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('报缺异常：${ErrorHandler.handleError(e)}'),
        ),
      );
    }
  }

  @override
  Future<BarcodeContent> fetchBarcode(String code) {
    return _service.getMaterialInfoByQR(code);
  }

  @override
  Future<List<String>> fetchMatControl(String matCode) async {
    final response = await _service.getMatControl(matCode);
    return response.split('!');
  }

  @override
  Future<Map<String, dynamic>> fetchStoreSite(String storeRoomNo, String siteNo) {
    return _service.getStoreSite(storeRoomNo, siteNo);
  }

  @override
  Future<Map<String, dynamic>> fetchInventory({
    required String storeSite,
    required BarcodeContent barcode,
    required String matControlFlag,
    required String erpRoom,
  }) async {
    final batchno = barcode.batchno ?? '';
    final matCode = barcode.matcode ?? '';
    double repQty = 0;
    String? erpStoreInv;

    if (matControlFlag == '1' || matControlFlag == '2') {
      final response = await _service.getRepertoryByStoreSiteNo(
        storeSite,
        matCode,
      );

      if (response['code'] == 200) {
        final repertoryList = (response['data'] as List?) ?? [];

        double repqtySum = 0;
        for (final item in repertoryList) {
          repqtySum += double.parse(item['repqty']?.toString() ?? '0');
        }
        repQty = repqtySum;

        final List<dynamic> drcheck = [];
        if (erpRoom.isNotEmpty) {
          for (final item in repertoryList) {
            if (item['erpStoreroom'] == erpRoom &&
                item['batchno'] == batchno) {
              drcheck.add(item);
              repQty = double.parse(item['repqty']?.toString() ?? '0');
            }
          }
        } else {
          for (final item in repertoryList) {
            if (item['batchno'] == batchno) {
              drcheck.add(item);
            }
          }
          if (drcheck.isNotEmpty) {
            repQty = drcheck.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + double.parse(element['repqty']?.toString() ?? '0'),
            );
          }
        }

        if (drcheck.isEmpty || repertoryList.isEmpty) {
          throw Exception(
            '物料【${barcode.matcode}】批次【$batchno】在库位【$storeSite】不存在，请确认',
          );
        }

        if (erpRoom.isNotEmpty && repertoryList.isNotEmpty) {
          final erpStoreInvValue = repertoryList[0]['erpStoreroom'];
          if (erpStoreInvValue != erpRoom) {
            throw Exception(
              '当前物料明细指定子库【$erpRoom】与当前库位的物料批次子库【$erpStoreInvValue】存在不一致，请确认',
            );
          }
          erpStoreInv = erpStoreInvValue?.toString();
        }
      }
    } else {
      double repqtySum31 = 0;
      double repqtySum41 = 0;

      final responseSn = await _service.getRepertoryByStoreSiteNoSn(
        storeSite,
        matCode,
        null,
        null,
        null,
      );

      if (responseSn['code'] == 200) {
        final repertoryList = (responseSn['data'] as List?) ?? [];
        if (repertoryList.isNotEmpty) {
          repQty = double.parse(repertoryList[0]['repqty']?.toString() ?? '0');
        }

        if (repQty <= 0) {
          throw Exception(
            '物料【${barcode.matcode}】批次【$batchno】序列【${barcode.sn}】 在库位【$storeSite】不存在，请确认',
          );
        }

        if (erpRoom.isNotEmpty) {
          final responseErp = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            matCode,
            erpRoom,
            barcode.batchno ?? '',
            barcode.sn ?? '',
          );
          if (responseErp['code'] == 200) {
            final erpList = responseErp['data'] as List;
            if (erpList.isNotEmpty) {
              repqtySum31 = double.parse(
                erpList[0]['repqty']?.toString() ?? '0',
              );
            }
          }
          repQty = repqtySum31;
        } else {
          final responseBatch = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            matCode,
            null,
            barcode.batchno ?? '',
            barcode.sn ?? '',
          );
          if (responseBatch['code'] == 200) {
            final batchList = responseBatch['data'] as List;
            if (batchList.isNotEmpty) {
              repqtySum41 = double.parse(
                batchList[0]['repqty']?.toString() ?? '0',
              );
            }
          }
          repQty = repqtySum41;
        }

        if (repQty <= 0) {
          throw Exception(
            '物料【${barcode.matcode}】批次【$batchno】序列【${barcode.sn}】在库位【$storeSite】不存在，请确认',
          );
        }

        final erpResponse = await _service.getRepertoryByStoreSiteNoErp(
          storeSite,
          matCode,
        );
        if (erpResponse['code'] == 200) {
          final erpList = erpResponse['data'] as List;
          if (erpList.isNotEmpty) {
            final erpStoreInvValue = erpList[0]['erpStoreroom'];
            if (erpRoom.isNotEmpty && erpStoreInvValue != erpRoom) {
              throw Exception(
                '当前物料明细指定子库【$erpRoom】与当前库位的物料批次子库【$erpStoreInvValue】存在不一致，请确认',
              );
            }
            erpStoreInv = erpStoreInvValue?.toString();
          }
        }
      }
    }

    return {
      'repQty': repQty,
      if (erpStoreInv != null) 'erpStoreInv': erpStoreInv,
    };
  }

  @override
  CollectionStock mapStock({
    required String stockId,
    required String matCode,
    required String batchNo,
    required String sn,
    required double taskQty,
    required double collectQty,
    required String outTaskItemId,
    required String taskId,
    required String storeRoom,
    required String storeSite,
    required String erpStore,
    required String trayNo,
  }) {
    return CollectionStock(
      stockid: stockId,
      matcode: matCode,
      batchno: batchNo,
      sn: sn,
      taskQty: taskQty,
      collectQty: collectQty,
      outtaskitemid: outTaskItemId,
      taskid: taskId,
      storeRoom: storeRoom,
      storeSite: storeSite,
      erpStore: erpStore,
      trayNo: trayNo,
    );
  }
}
