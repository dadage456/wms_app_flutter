import '../models/mtl_senter_models.dart';

abstract class MtlSenterCollectionEvent {
  const MtlSenterCollectionEvent();
}

class MtlSenterCollectionStarted extends MtlSenterCollectionEvent {
  const MtlSenterCollectionStarted({this.task, this.operatorId});

  final MtlSenterTask? task;
  final String? operatorId;
}

class MtlSenterBarcodeScanned extends MtlSenterCollectionEvent {
  const MtlSenterBarcodeScanned(this.barcode);

  final String barcode;
}

class MtlSenterDeleteSelected extends MtlSenterCollectionEvent {
  const MtlSenterDeleteSelected();
}

class MtlSenterToggleSelection extends MtlSenterCollectionEvent {
  const MtlSenterToggleSelection(this.id);

  final String id;
}

class MtlSenterSelectionChanged extends MtlSenterCollectionEvent {
  const MtlSenterSelectionChanged(this.ids);

  final Set<String> ids;
}

class MtlSenterSubmitRequested extends MtlSenterCollectionEvent {
  const MtlSenterSubmitRequested();
}

class MtlSenterResetStatus extends MtlSenterCollectionEvent {
  const MtlSenterResetStatus();
}

class MtlSenterClearCurrentInput extends MtlSenterCollectionEvent {
  const MtlSenterClearCurrentInput();
}

class MtlSenterFocusConsumed extends MtlSenterCollectionEvent {
  const MtlSenterFocusConsumed();
}
