class AswhUpWcsInstruction {
  const AswhUpWcsInstruction({
    this.trayNo,
    this.startAddress,
    this.destinationAddress,
    this.stackerNo,
    this.sendTime,
    this.stateLabel,
    this.weightGrade,
    this.heightGrade,
    this.taskNo,
    this.voucherNo,
    this.taskTypeLabel,
    this.changeTypeLabel,
    this.inOutTypeLabel,
    this.wcsErrorMessage,
    this.taskId,
    this.voucherId,
    this.instructionId,
  });

  final String? trayNo;
  final String? startAddress;
  final String? destinationAddress;
  final String? stackerNo;
  final String? sendTime;
  final String? stateLabel;
  final String? weightGrade;
  final String? heightGrade;
  final String? taskNo;
  final String? voucherNo;
  final String? taskTypeLabel;
  final String? changeTypeLabel;
  final String? inOutTypeLabel;
  final String? wcsErrorMessage;
  final int? taskId;
  final int? voucherId;
  final int? instructionId;

  factory AswhUpWcsInstruction.fromJson(Map<String, dynamic> json) {
    int? _parseInt(Object? value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value);
      }
      return null;
    }

    return AswhUpWcsInstruction(
      trayNo: json['palno']?.toString(),
      startAddress: json['saddr']?.toString(),
      destinationAddress: json['daddr']?.toString(),
      stackerNo: json['dvno']?.toString(),
      sendTime: json['sendtime2']?.toString(),
      stateLabel: json['state2']?.toString(),
      weightGrade: json['weightGrade2']?.toString(),
      heightGrade: json['highGrade2']?.toString(),
      taskNo: json['taskNo']?.toString(),
      voucherNo: json['proofno']?.toString(),
      taskTypeLabel: json['tasktype2']?.toString(),
      changeTypeLabel: json['changetype2']?.toString(),
      inOutTypeLabel: json['typ2']?.toString(),
      wcsErrorMessage: json['wcsErrMessage2']?.toString(),
      taskId: _parseInt(json['taskId']),
      voucherId: _parseInt(json['proofid']),
      instructionId: _parseInt(json['interfaceWmsToWcsId']),
    );
  }
}
