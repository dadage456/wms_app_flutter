import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';

class ExceptionCollectionArgs {
  final OutboundTask task;
  final String? trayNo;
  final String? storeSite;

  const ExceptionCollectionArgs({
    required this.task,
    this.trayNo,
    this.storeSite,
  });
}
