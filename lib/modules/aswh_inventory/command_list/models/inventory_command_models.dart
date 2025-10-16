import 'package:equatable/equatable.dart';

/// WMS -> WCS 指令记录
class InventoryWcsCommand extends Equatable {
  const InventoryWcsCommand({
    this.interfaceId,
    this.palletNo,
    this.startAddr,
    this.destAddr,
    this.stackerNo,
    this.sendTime,
    this.state,
    this.weightGrade,
    this.highGrade,
    this.taskNo,
    this.proofNo,
    this.taskType,
    this.changeType,
    this.ioType,
    this.wcsError,
    this.taskId,
    this.proofId,
  });

  factory InventoryWcsCommand.fromJson(Map<String, dynamic> json) {
    return InventoryWcsCommand(
      interfaceId: json['interfaceWmsToWcsId']?.toString(),
      palletNo: json['palno']?.toString(),
      startAddr: json['saddr']?.toString(),
      destAddr: json['daddr']?.toString(),
      stackerNo: json['dvno']?.toString(),
      sendTime: json['sendtime2']?.toString(),
      state: json['state2']?.toString(),
      weightGrade: json['weightGrade2']?.toString(),
      highGrade: json['highGrade2']?.toString(),
      taskNo: json['taskNo']?.toString(),
      proofNo: json['proofno']?.toString(),
      taskType: json['tasktype2']?.toString(),
      changeType: json['changetype2']?.toString(),
      ioType: json['typ2']?.toString(),
      wcsError: json['wcsErrMessage2']?.toString(),
      taskId: json['taskId']?.toString(),
      proofId: json['proofid']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'interfaceWmsToWcsId': interfaceId,
      'palno': palletNo,
      'saddr': startAddr,
      'daddr': destAddr,
      'dvno': stackerNo,
      'sendtime2': sendTime,
      'state2': state,
      'weightGrade2': weightGrade,
      'highGrade2': highGrade,
      'taskNo': taskNo,
      'proofno': proofNo,
      'tasktype2': taskType,
      'changetype2': changeType,
      'typ2': ioType,
      'wcsErrMessage2': wcsError,
      'taskId': taskId,
      'proofid': proofId,
    };
  }

  final String? interfaceId;
  final String? palletNo;
  final String? startAddr;
  final String? destAddr;
  final String? stackerNo;
  final String? sendTime;
  final String? state;
  final String? weightGrade;
  final String? highGrade;
  final String? taskNo;
  final String? proofNo;
  final String? taskType;
  final String? changeType;
  final String? ioType;
  final String? wcsError;
  final String? taskId;
  final String? proofId;

  @override
  List<Object?> get props => [
        interfaceId,
        palletNo,
        startAddr,
        destAddr,
        stackerNo,
        sendTime,
        state,
        weightGrade,
        highGrade,
        taskNo,
        proofNo,
        taskType,
        changeType,
        ioType,
        wcsError,
        taskId,
        proofId,
      ];
}

/// 指令类别：在线拣选 or 盘点采集结果
enum InventoryCommandCategory {
  inventory,
  checkOrder,
}

/// 页面底部操作类型
enum InventoryCommandAction {
  revokeBack,
  revokeOutbound,
}
