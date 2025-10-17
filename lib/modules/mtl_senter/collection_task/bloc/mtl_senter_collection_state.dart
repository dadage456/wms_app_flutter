import 'package:equatable/equatable.dart';

import '../../../../models/page_status.dart';
import '../models/mtl_senter_models.dart';

class MtlSenterCollectionState extends Equatable {
  const MtlSenterCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.task,
    this.operatorId,
    this.currentLocation,
    this.currentMaterial,
    this.currentQuantity,
    this.availableQty = 0,
    this.minPackageQty,
    this.defaultDeliveryQty,
    this.stocks = const [],
    this.selectedIds = const {},
    this.collectedQtyMap = const {},
    this.scanStep = MtlSenterScanStep.location,
    this.focus = false,
  });

  final CollectionStatus status;
  final MtlSenterTask? task;
  final String? operatorId;
  final String? currentLocation;
  final MtlSenterMaterial? currentMaterial;
  final double? currentQuantity;
  final double availableQty;
  final double? minPackageQty;
  final double? defaultDeliveryQty;
  final List<MtlSenterCollectItem> stocks;
  final Set<String> selectedIds;
  final Map<String, double> collectedQtyMap;
  final MtlSenterScanStep scanStep;
  final bool focus;

  String get placeholder => scanStep.placeholder;

  bool get canSubmit => stocks.isNotEmpty;

  bool get hasSelection => selectedIds.isNotEmpty;

  MtlSenterCollectionState copyWith({
    CollectionStatus? status,
    MtlSenterTask? task,
    String? operatorId,
    String? currentLocation,
    MtlSenterMaterial? currentMaterial,
    double? currentQuantity,
    double? availableQty,
    double? minPackageQty,
    double? defaultDeliveryQty,
    List<MtlSenterCollectItem>? stocks,
    Set<String>? selectedIds,
    Map<String, double>? collectedQtyMap,
    MtlSenterScanStep? scanStep,
    bool? focus,
  }) {
    return MtlSenterCollectionState(
      status: status ?? this.status,
      task: task ?? this.task,
      operatorId: operatorId ?? this.operatorId,
      currentLocation: currentLocation ?? this.currentLocation,
      currentMaterial: currentMaterial ?? this.currentMaterial,
      currentQuantity: currentQuantity ?? this.currentQuantity,
      availableQty: availableQty ?? this.availableQty,
      minPackageQty: minPackageQty ?? this.minPackageQty,
      defaultDeliveryQty: defaultDeliveryQty ?? this.defaultDeliveryQty,
      stocks: stocks ?? this.stocks,
      selectedIds: selectedIds ?? this.selectedIds,
      collectedQtyMap: collectedQtyMap ?? this.collectedQtyMap,
      scanStep: scanStep ?? this.scanStep,
      focus: focus ?? this.focus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        task,
        operatorId,
        currentLocation,
        currentMaterial,
        currentQuantity,
        availableQty,
        minPackageQty,
        defaultDeliveryQty,
        stocks,
        selectedIds,
        collectedQtyMap,
        scanStep,
        focus,
      ];
}
