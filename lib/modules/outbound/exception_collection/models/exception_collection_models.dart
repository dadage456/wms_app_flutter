import 'package:uuid/uuid.dart';

/// 异常采集列表行数据
class ExceptionCollectionItem {
  final String id;
  final String matCode;
  final String storeSite;
  final String exceptionName;
  final double qty;
  final String batchNo;
  final String sn;
  final String storeRoom;
  final String proType;
  final String taskId;

  const ExceptionCollectionItem({
    required this.id,
    required this.matCode,
    required this.storeSite,
    required this.exceptionName,
    required this.qty,
    required this.batchNo,
    required this.sn,
    required this.storeRoom,
    required this.proType,
    required this.taskId,
  });

  ExceptionCollectionItem copyWith({
    String? id,
    String? matCode,
    String? storeSite,
    String? exceptionName,
    double? qty,
    String? batchNo,
    String? sn,
    String? storeRoom,
    String? proType,
    String? taskId,
  }) {
    return ExceptionCollectionItem(
      id: id ?? this.id,
      matCode: matCode ?? this.matCode,
      storeSite: storeSite ?? this.storeSite,
      exceptionName: exceptionName ?? this.exceptionName,
      qty: qty ?? this.qty,
      batchNo: batchNo ?? this.batchNo,
      sn: sn ?? this.sn,
      storeRoom: storeRoom ?? this.storeRoom,
      proType: proType ?? this.proType,
      taskId: taskId ?? this.taskId,
    );
  }

  static ExceptionCollectionItem create({
    required String matCode,
    required String storeSite,
    required String exceptionName,
    required double qty,
    required String batchNo,
    required String sn,
    required String storeRoom,
    required String proType,
    required String taskId,
  }) {
    return ExceptionCollectionItem(
      id: const Uuid().v4(),
      matCode: matCode,
      storeSite: storeSite,
      exceptionName: exceptionName,
      qty: qty,
      batchNo: batchNo,
      sn: sn,
      storeRoom: storeRoom,
      proType: proType,
      taskId: taskId,
    );
  }
}

/// 提交异常采集的明细
class ExceptionStock {
  final String id;
  final String matCode;
  final String batchNo;
  final String sn;
  final double taskQty;
  final double collectQty;
  final String storeRoom;
  final String storeSite;
  final String taskId;
  final String exceptionType;

  const ExceptionStock({
    required this.id,
    required this.matCode,
    required this.batchNo,
    required this.sn,
    required this.taskQty,
    required this.collectQty,
    required this.storeRoom,
    required this.storeSite,
    required this.taskId,
    required this.exceptionType,
  });

  Map<String, dynamic> toPayload({
    required String taskNo,
    required String proType,
    required String proofNo,
  }) {
    return {
      'taskNo': taskNo,
      'matCode': matCode,
      'batchNo': batchNo,
      'sn': sn,
      'taskQty': taskQty,
      'collectQty': collectQty,
      'storeRoomNo': storeRoom,
      'storeSiteNo': storeSite,
      'taskid': taskId,
      'excepttype': exceptionType,
      'protype': proType,
      'proofNo': proofNo,
    };
  }

  ExceptionStock copyWith({
    String? id,
    String? matCode,
    String? batchNo,
    String? sn,
    double? taskQty,
    double? collectQty,
    String? storeRoom,
    String? storeSite,
    String? taskId,
    String? exceptionType,
  }) {
    return ExceptionStock(
      id: id ?? this.id,
      matCode: matCode ?? this.matCode,
      batchNo: batchNo ?? this.batchNo,
      sn: sn ?? this.sn,
      taskQty: taskQty ?? this.taskQty,
      collectQty: collectQty ?? this.collectQty,
      storeRoom: storeRoom ?? this.storeRoom,
      storeSite: storeSite ?? this.storeSite,
      taskId: taskId ?? this.taskId,
      exceptionType: exceptionType ?? this.exceptionType,
    );
  }
}

class ExceptionTypeOption {
  final String value;
  final String label;

  const ExceptionTypeOption({required this.value, required this.label});
}
