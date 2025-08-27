import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'outbound_task.freezed.dart';
part 'outbound_task.g.dart';

/// 出库任务模型
@freezed
class OutboundTask with _$OutboundTask {
  const factory OutboundTask({
    /// 出库任务ID - 任务的唯一标识
    @JsonKey(name: 'outtaskid') required String outTaskId,
    
    /// 任务号 - 业务任务编号
    @JsonKey(name: 'outtaskno') required String outTaskNo,
    
    /// 出库单号 - 业务单据编号
    @JsonKey(name: 'orderno') required String orderNo,
    
    /// 来源单号 - 原始订单编号
    @JsonKey(name: 'po_number') required String poNumber,
    
    /// 库房号 - 物料所在库房编号
    @JsonKey(name: 'storeroomno') required String storeRoomNo,
    
    /// 工位 - 执行任务的工作站
    @JsonKey(name: 'workstation') required String workStation,
    
    /// 凭证号 - 财务凭证编号
    @JsonKey(name: 'taskcomment') required String taskComment,
    
    /// 班组 - 执行任务的班组名称
    @JsonKey(name: 'schedule_group_name') required String scheduleGroupName,
    
    /// 紧急补单 - 是否为紧急补单标识
    @JsonKey(name: 'wip_supplement_flag') required String wipSupplementFlag,
    
    /// 创建时间 - 任务创建的时间戳
    @JsonKey(name: 'createtime') required String createTime,
    
    /// 状态 - 任务当前执行状态
    @JsonKey(name: 'status') required String status,
    
    /// 任务数量 - 计划出库的总数量
    @JsonKey(name: 'taskqty') @Default(0) int taskQty,
    
    /// 完成数量 - 已完成出库的数量
    @JsonKey(name: 'finishqty') @Default(0) int finishQty,
  }) = _OutboundTask;

  factory OutboundTask.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskFromJson(json);
}

/// 出库任务查询参数
class OutboundTaskQuery extends Equatable {
  const OutboundTaskQuery({
    this.sortType = '',
    this.sortColumn = '',
    this.searchKey = '',
    required this.userId,
    required this.roleOrUserId,
    this.roomTag = '0',
    this.batchFlag = '0',
    this.transferType = '0',
    this.beatFlag = 'N',
    this.pageIndex = 1,
    this.pageSize = 100,
    this.finishFlag = '0',
  });

  /// 排序类型 - 控制数据排序方向 (ASC/DESC)
  final String sortType;
  
  /// 排序字段 - 指定按哪个字段排序
  final String sortColumn;
  
  /// 搜索关键字 - 支持扫码输入的单号搜索
  final String searchKey;
  
  /// 用户ID - 当前登录用户的唯一标识
  final String userId;
  
  /// 角色或用户ID - 权限控制相关
  final String roleOrUserId;
  
  /// 库房标签 - 区分不同类型的库房 ('0': 平库)
  final String roomTag;
  
  /// 批次标志 - 批次管理相关标识
  final String batchFlag;
  
  /// 转移类型 - 物料转移操作类型
  final String transferType;
  
  /// 节拍标志 - 是否按节拍执行 ('N': 否, 'Y': 是)
  final String beatFlag;
  
  /// 页码 - 当前查询的页面索引 (从1开始)
  final int pageIndex;
  
  /// 页面大小 - 每页显示的记录数
  final int pageSize;
  
  /// 完成标志 - 任务状态筛选 ('0': 采集中, '1': 所有)
  final String finishFlag;

  @override
  List<Object?> get props => [
        sortType,
        sortColumn,
        searchKey,
        userId,
        roleOrUserId,
        roomTag,
        batchFlag,
        transferType,
        beatFlag,
        pageIndex,
        pageSize,
        finishFlag,
      ];

  OutboundTaskQuery copyWith({
    String? sortType,
    String? sortColumn,
    String? searchKey,
    String? userId,
    String? roleOrUserId,
    String? roomTag,
    String? batchFlag,
    String? transferType,
    String? beatFlag,
    int? pageIndex,
    int? pageSize,
    String? finishFlag,
  }) {
    return OutboundTaskQuery(
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
      searchKey: searchKey ?? this.searchKey,
      userId: userId ?? this.userId,
      roleOrUserId: roleOrUserId ?? this.roleOrUserId,
      roomTag: roomTag ?? this.roomTag,
      batchFlag: batchFlag ?? this.batchFlag,
      transferType: transferType ?? this.transferType,
      beatFlag: beatFlag ?? this.beatFlag,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      finishFlag: finishFlag ?? this.finishFlag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sortType': sortType,
      'sortColumn': sortColumn,
      'searchKey': searchKey,
      'userId': userId,
      'roleoRuserId': roleOrUserId,
      'roomTag': roomTag,
      'batchflag': batchFlag,
      'transferType': transferType,
      'beatflag': beatFlag,
      'PageIndex': pageIndex.toString(),
      'PageSize': pageSize.toString(),
      'finshFlg': finishFlag,
    };
  }
}

/// 出库任务列表响应
@freezed
class OutboundTaskListResponse with _$OutboundTaskListResponse {
  const factory OutboundTaskListResponse({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'msg') required String message,
    @JsonKey(name: 'data') required OutboundTaskListData data,
  }) = _OutboundTaskListResponse;

  factory OutboundTaskListResponse.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskListResponseFromJson(json);
}

/// 出库任务列表数据
@freezed
class OutboundTaskListData with _$OutboundTaskListData {
  const factory OutboundTaskListData({
    @JsonKey(name: 'rows') @Default([]) List<OutboundTask> rows,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _OutboundTaskListData;

  factory OutboundTaskListData.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskListDataFromJson(json);
}