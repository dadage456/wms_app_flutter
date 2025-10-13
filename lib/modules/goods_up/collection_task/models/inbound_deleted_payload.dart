import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';

class InboundDeletedStocksPayload {
  const InboundDeletedStocksPayload(this.deletedStocks);

  final List<InboundCollectionStock> deletedStocks;
}
