import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../goods_up/collection_task/models/inbound_collection_request.dart';
import '../../goods_up/services/goods_up_task_service.dart';
import '../collection_task/models/transfer_collection_models.dart';

part 'transfer_task_service.freezed.dart';
part 'transfer_task_service.g.dart';

/// 平库移库任务服务封装
class TransferTaskService {
  TransferTaskService(this._dio, this._goodsUpService);

  final Dio _dio;
  final GoodsUpTaskService _goodsUpService;

  /// 校验库位是否存在并返回基础信息
  Future<TransferStoreSiteInfo?> validateStoreSite({
    required String storeRoomNo,
    required String storeSiteNo,
  }) async {
    final result = await _goodsUpService.getStoreSiteByRoom(
      storeRoomNo: storeRoomNo,
      storeSiteNo: storeSiteNo,
    );

    if (result.isEmpty) return null;
    final info = TransferStoreSiteInfo.fromJson(
      Map<String, dynamic>.from(result.first),
    );
    return info;
  }

  /// 通过条码解析物料信息
  Future<TransferMaterialDetail> fetchMaterialByQr(String content) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getPmMaterialInfoByQR',
      data: {'qrContent': content},
    );

    final body = response.data?['data'] ?? response.data?['rows'] ?? response.data;
    if (body is Map<String, dynamic>) {
      return TransferMaterialDetail.fromJson(body);
    }
    if (body is List && body.isNotEmpty) {
      return TransferMaterialDetail.fromJson(
        Map<String, dynamic>.from(body.first as Map),
      );
    }
    throw Exception('未能识别条码信息，请重新扫描');
  }

  /// 查询转储库存（来源、目标组合）
  Future<List<TransferInventoryRow>> fetchTransferInventory({
    required String sourceSite,
    required String targetSite,
  }) async {
    final result = await _goodsUpService.getRepertoryByStoresiteNoTransfer(
      sourceStoreSiteNo: sourceSite,
      targetStoreSiteNo: targetSite,
    );
    return result
        .map((item) => TransferInventoryRow.fromJson(
              Map<String, dynamic>.from(item),
            ))
        .toList();
  }

  /// 根据库位与物料编码查询库存
  Future<List<TransferInventoryRow>> fetchInventoryBySiteAndMaterial({
    required String storeSite,
    required String materialCode,
    String? batchNo,
  }) async {
    final result = await _goodsUpService.getRepertoryBySiteNoMatCode(
      storeSiteNo: storeSite,
      materialCode: materialCode,
      batchNo: batchNo ?? '',
    );
    return result
        .map(
          (item) => TransferInventoryRow.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  /// 查询物料在库数量
  Future<List<TransferInventoryRow>> fetchQtyByMaterial({
    required String materialCode,
    required String siteNo,
  }) async {
    final result = await _goodsUpService.getMtlQtyByMtlCode(
      materialCode: materialCode,
      siteNo: siteNo,
    );
    return result
        .map(
          (item) => TransferInventoryRow.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  /// 提交移库采集数据
  Future<void> submitTransfer(TransferSubmitPayload payload) async {
    final request = GoodsUpTransferRequest(
      transferInfos: payload.entries
          .map((entry) => entry.toJson())
          .map((json) => Map<String, dynamic>.from(json))
          .toList(),
      filter: payload.filter,
    );
    await _goodsUpService.commitTransfer(request: request);
  }
}

/// 库位信息
@freezed
class TransferStoreSiteInfo with _$TransferStoreSiteInfo {
  const factory TransferStoreSiteInfo({
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'storeroomname') String? storeRoomName,
    @JsonKey(name: 'erpstoreroom') String? erpStoreRoom,
    @JsonKey(name: 'erpStoreroom') String? erpStoreRoomUpper,
    @JsonKey(name: 'erpOwnerCode') String? erpOwnerCode,
    @JsonKey(name: 'projectNum') String? projectNumber,
    @JsonKey(name: 'isfrozen') dynamic frozenFlag,
    @JsonKey(name: 'isFrozen') dynamic frozenFlagUpper,
  }) = _TransferStoreSiteInfo;

  const TransferStoreSiteInfo._();

  String? get resolvedErpStoreRoom =>
      (erpStoreRoomUpper ?? erpStoreRoom)?.toString();

  bool get isFrozen {
    final value = frozenFlagUpper ?? frozenFlag;
    if (value == null) return false;
    return value.toString() != '0';
  }

  factory TransferStoreSiteInfo.fromJson(Map<String, dynamic> json) =>
      _$TransferStoreSiteInfoFromJson(json);
}

/// 扫码解析后的物料信息
@freezed
class TransferMaterialDetail with _$TransferMaterialDetail {
  const factory TransferMaterialDetail({
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matCode') String? materialCodeUpper,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'matcontrol') String? controlFlag,
    @JsonKey(name: 'matControl') String? controlFlagUpper,
    @JsonKey(name: 'qty') dynamic quantity,
    @JsonKey(name: 'projectNum') String? projectNumber,
    @JsonKey(name: 'erpStoreroom') String? erpStoreRoom,
    @JsonKey(name: 'erpOwnerCode') String? ownerCode,
  }) = _TransferMaterialDetail;

  const TransferMaterialDetail._();

  String get resolvedMaterialCode =>
      (materialCodeUpper ?? materialCode ?? '').trim();

  String get resolvedControlFlag =>
      (controlFlagUpper ?? controlFlag ?? '').trim();

  double get resolvedQuantity =>
      quantity is num ? (quantity as num).toDouble() : 0;

  factory TransferMaterialDetail.fromJson(Map<String, dynamic> json) =>
      _$TransferMaterialDetailFromJson(json);
}
