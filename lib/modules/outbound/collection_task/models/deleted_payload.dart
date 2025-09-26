import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';

class DeletedStocksPayload {
  final List<CollectionStock> deletedStocks;
  const DeletedStocksPayload(this.deletedStocks);
}
