// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_collect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OutboundCollectState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundCollectStateCopyWith<$Res> {
  factory $OutboundCollectStateCopyWith(
    OutboundCollectState value,
    $Res Function(OutboundCollectState) then,
  ) = _$OutboundCollectStateCopyWithImpl<$Res, OutboundCollectState>;
}

/// @nodoc
class _$OutboundCollectStateCopyWithImpl<
  $Res,
  $Val extends OutboundCollectState
>
    implements $OutboundCollectStateCopyWith<$Res> {
  _$OutboundCollectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OutboundCollectInitialImplCopyWith<$Res> {
  factory _$$OutboundCollectInitialImplCopyWith(
    _$OutboundCollectInitialImpl value,
    $Res Function(_$OutboundCollectInitialImpl) then,
  ) = __$$OutboundCollectInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OutboundCollectInitialImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<$Res, _$OutboundCollectInitialImpl>
    implements _$$OutboundCollectInitialImplCopyWith<$Res> {
  __$$OutboundCollectInitialImplCopyWithImpl(
    _$OutboundCollectInitialImpl _value,
    $Res Function(_$OutboundCollectInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OutboundCollectInitialImpl implements OutboundCollectInitial {
  const _$OutboundCollectInitialImpl();

  @override
  String toString() {
    return 'OutboundCollectState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectInitial implements OutboundCollectState {
  const factory OutboundCollectInitial() = _$OutboundCollectInitialImpl;
}

/// @nodoc
abstract class _$$OutboundCollectLoadingImplCopyWith<$Res> {
  factory _$$OutboundCollectLoadingImplCopyWith(
    _$OutboundCollectLoadingImpl value,
    $Res Function(_$OutboundCollectLoadingImpl) then,
  ) = __$$OutboundCollectLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OutboundCollectLoadingImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<$Res, _$OutboundCollectLoadingImpl>
    implements _$$OutboundCollectLoadingImplCopyWith<$Res> {
  __$$OutboundCollectLoadingImplCopyWithImpl(
    _$OutboundCollectLoadingImpl _value,
    $Res Function(_$OutboundCollectLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OutboundCollectLoadingImpl implements OutboundCollectLoading {
  const _$OutboundCollectLoadingImpl();

  @override
  String toString() {
    return 'OutboundCollectState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectLoading implements OutboundCollectState {
  const factory OutboundCollectLoading() = _$OutboundCollectLoadingImpl;
}

/// @nodoc
abstract class _$$OutboundCollectLoadedImplCopyWith<$Res> {
  factory _$$OutboundCollectLoadedImplCopyWith(
    _$OutboundCollectLoadedImpl value,
    $Res Function(_$OutboundCollectLoadedImpl) then,
  ) = __$$OutboundCollectLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    OutboundTask task,
    List<OutboundTaskItem> taskItems,
    List<CollectRecord> collectRecords,
    int currentTabIndex,
    ScanStep currentScanStep,
    String userId,
    String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
    bool isSubmitting,
    bool isValidating,
    String? errorMessage,
    String? successMessage,
  });

  $OutboundTaskCopyWith<$Res> get task;
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent;
}

/// @nodoc
class __$$OutboundCollectLoadedImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<$Res, _$OutboundCollectLoadedImpl>
    implements _$$OutboundCollectLoadedImplCopyWith<$Res> {
  __$$OutboundCollectLoadedImplCopyWithImpl(
    _$OutboundCollectLoadedImpl _value,
    $Res Function(_$OutboundCollectLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? taskItems = null,
    Object? collectRecords = null,
    Object? currentTabIndex = null,
    Object? currentScanStep = null,
    Object? userId = null,
    Object? workStation = null,
    Object? currentSiteCode = freezed,
    Object? currentBarcodeContent = freezed,
    Object? currentInventory = freezed,
    Object? isSubmitting = null,
    Object? isValidating = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$OutboundCollectLoadedImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask,
        taskItems: null == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<OutboundTaskItem>,
        collectRecords: null == collectRecords
            ? _value._collectRecords
            : collectRecords // ignore: cast_nullable_to_non_nullable
                  as List<CollectRecord>,
        currentTabIndex: null == currentTabIndex
            ? _value.currentTabIndex
            : currentTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentScanStep: null == currentScanStep
            ? _value.currentScanStep
            : currentScanStep // ignore: cast_nullable_to_non_nullable
                  as ScanStep,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        workStation: null == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String,
        currentSiteCode: freezed == currentSiteCode
            ? _value.currentSiteCode
            : currentSiteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBarcodeContent: freezed == currentBarcodeContent
            ? _value.currentBarcodeContent
            : currentBarcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent?,
        currentInventory: freezed == currentInventory
            ? _value._currentInventory
            : currentInventory // ignore: cast_nullable_to_non_nullable
                  as List<InventoryInfo>?,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        isValidating: null == isValidating
            ? _value.isValidating
            : isValidating // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res> get task {
    return $OutboundTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent {
    if (_value.currentBarcodeContent == null) {
      return null;
    }

    return $BarcodeContentCopyWith<$Res>(_value.currentBarcodeContent!, (
      value,
    ) {
      return _then(_value.copyWith(currentBarcodeContent: value));
    });
  }
}

/// @nodoc

class _$OutboundCollectLoadedImpl implements OutboundCollectLoaded {
  const _$OutboundCollectLoadedImpl({
    required this.task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required this.currentTabIndex,
    required this.currentScanStep,
    required this.userId,
    required this.workStation,
    this.currentSiteCode,
    this.currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
    this.isSubmitting = false,
    this.isValidating = false,
    this.errorMessage,
    this.successMessage,
  }) : _taskItems = taskItems,
       _collectRecords = collectRecords,
       _currentInventory = currentInventory;

  @override
  final OutboundTask task;
  final List<OutboundTaskItem> _taskItems;
  @override
  List<OutboundTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  final List<CollectRecord> _collectRecords;
  @override
  List<CollectRecord> get collectRecords {
    if (_collectRecords is EqualUnmodifiableListView) return _collectRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectRecords);
  }

  @override
  final int currentTabIndex;
  @override
  final ScanStep currentScanStep;
  @override
  final String userId;
  @override
  final String workStation;
  @override
  final String? currentSiteCode;
  @override
  final BarcodeContent? currentBarcodeContent;
  final List<InventoryInfo>? _currentInventory;
  @override
  List<InventoryInfo>? get currentInventory {
    final value = _currentInventory;
    if (value == null) return null;
    if (_currentInventory is EqualUnmodifiableListView)
      return _currentInventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isValidating;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'OutboundCollectState.loaded(task: $task, taskItems: $taskItems, collectRecords: $collectRecords, currentTabIndex: $currentTabIndex, currentScanStep: $currentScanStep, userId: $userId, workStation: $workStation, currentSiteCode: $currentSiteCode, currentBarcodeContent: $currentBarcodeContent, currentInventory: $currentInventory, isSubmitting: $isSubmitting, isValidating: $isValidating, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectLoadedImpl &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._collectRecords,
              _collectRecords,
            ) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.currentScanStep, currentScanStep) ||
                other.currentScanStep == currentScanStep) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.currentSiteCode, currentSiteCode) ||
                other.currentSiteCode == currentSiteCode) &&
            (identical(other.currentBarcodeContent, currentBarcodeContent) ||
                other.currentBarcodeContent == currentBarcodeContent) &&
            const DeepCollectionEquality().equals(
              other._currentInventory,
              _currentInventory,
            ) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    task,
    const DeepCollectionEquality().hash(_taskItems),
    const DeepCollectionEquality().hash(_collectRecords),
    currentTabIndex,
    currentScanStep,
    userId,
    workStation,
    currentSiteCode,
    currentBarcodeContent,
    const DeepCollectionEquality().hash(_currentInventory),
    isSubmitting,
    isValidating,
    errorMessage,
    successMessage,
  );

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundCollectLoadedImplCopyWith<_$OutboundCollectLoadedImpl>
  get copyWith =>
      __$$OutboundCollectLoadedImplCopyWithImpl<_$OutboundCollectLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return loaded(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
      isSubmitting,
      isValidating,
      errorMessage,
      successMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return loaded?.call(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
      isSubmitting,
      isValidating,
      errorMessage,
      successMessage,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        task,
        taskItems,
        collectRecords,
        currentTabIndex,
        currentScanStep,
        userId,
        workStation,
        currentSiteCode,
        currentBarcodeContent,
        currentInventory,
        isSubmitting,
        isValidating,
        errorMessage,
        successMessage,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectLoaded implements OutboundCollectState {
  const factory OutboundCollectLoaded({
    required final OutboundTask task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required final int currentTabIndex,
    required final ScanStep currentScanStep,
    required final String userId,
    required final String workStation,
    final String? currentSiteCode,
    final BarcodeContent? currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
    final bool isSubmitting,
    final bool isValidating,
    final String? errorMessage,
    final String? successMessage,
  }) = _$OutboundCollectLoadedImpl;

  OutboundTask get task;
  List<OutboundTaskItem> get taskItems;
  List<CollectRecord> get collectRecords;
  int get currentTabIndex;
  ScanStep get currentScanStep;
  String get userId;
  String get workStation;
  String? get currentSiteCode;
  BarcodeContent? get currentBarcodeContent;
  List<InventoryInfo>? get currentInventory;
  bool get isSubmitting;
  bool get isValidating;
  String? get errorMessage;
  String? get successMessage;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboundCollectLoadedImplCopyWith<_$OutboundCollectLoadedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutboundCollectScanProcessingImplCopyWith<$Res> {
  factory _$$OutboundCollectScanProcessingImplCopyWith(
    _$OutboundCollectScanProcessingImpl value,
    $Res Function(_$OutboundCollectScanProcessingImpl) then,
  ) = __$$OutboundCollectScanProcessingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    OutboundTask task,
    List<OutboundTaskItem> taskItems,
    List<CollectRecord> collectRecords,
    int currentTabIndex,
    ScanStep currentScanStep,
    String userId,
    String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
    String scanContent,
  });

  $OutboundTaskCopyWith<$Res> get task;
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent;
}

/// @nodoc
class __$$OutboundCollectScanProcessingImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<
          $Res,
          _$OutboundCollectScanProcessingImpl
        >
    implements _$$OutboundCollectScanProcessingImplCopyWith<$Res> {
  __$$OutboundCollectScanProcessingImplCopyWithImpl(
    _$OutboundCollectScanProcessingImpl _value,
    $Res Function(_$OutboundCollectScanProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? taskItems = null,
    Object? collectRecords = null,
    Object? currentTabIndex = null,
    Object? currentScanStep = null,
    Object? userId = null,
    Object? workStation = null,
    Object? currentSiteCode = freezed,
    Object? currentBarcodeContent = freezed,
    Object? currentInventory = freezed,
    Object? scanContent = null,
  }) {
    return _then(
      _$OutboundCollectScanProcessingImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask,
        taskItems: null == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<OutboundTaskItem>,
        collectRecords: null == collectRecords
            ? _value._collectRecords
            : collectRecords // ignore: cast_nullable_to_non_nullable
                  as List<CollectRecord>,
        currentTabIndex: null == currentTabIndex
            ? _value.currentTabIndex
            : currentTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentScanStep: null == currentScanStep
            ? _value.currentScanStep
            : currentScanStep // ignore: cast_nullable_to_non_nullable
                  as ScanStep,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        workStation: null == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String,
        currentSiteCode: freezed == currentSiteCode
            ? _value.currentSiteCode
            : currentSiteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBarcodeContent: freezed == currentBarcodeContent
            ? _value.currentBarcodeContent
            : currentBarcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent?,
        currentInventory: freezed == currentInventory
            ? _value._currentInventory
            : currentInventory // ignore: cast_nullable_to_non_nullable
                  as List<InventoryInfo>?,
        scanContent: null == scanContent
            ? _value.scanContent
            : scanContent // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res> get task {
    return $OutboundTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent {
    if (_value.currentBarcodeContent == null) {
      return null;
    }

    return $BarcodeContentCopyWith<$Res>(_value.currentBarcodeContent!, (
      value,
    ) {
      return _then(_value.copyWith(currentBarcodeContent: value));
    });
  }
}

/// @nodoc

class _$OutboundCollectScanProcessingImpl
    implements OutboundCollectScanProcessing {
  const _$OutboundCollectScanProcessingImpl({
    required this.task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required this.currentTabIndex,
    required this.currentScanStep,
    required this.userId,
    required this.workStation,
    this.currentSiteCode,
    this.currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
    required this.scanContent,
  }) : _taskItems = taskItems,
       _collectRecords = collectRecords,
       _currentInventory = currentInventory;

  @override
  final OutboundTask task;
  final List<OutboundTaskItem> _taskItems;
  @override
  List<OutboundTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  final List<CollectRecord> _collectRecords;
  @override
  List<CollectRecord> get collectRecords {
    if (_collectRecords is EqualUnmodifiableListView) return _collectRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectRecords);
  }

  @override
  final int currentTabIndex;
  @override
  final ScanStep currentScanStep;
  @override
  final String userId;
  @override
  final String workStation;
  @override
  final String? currentSiteCode;
  @override
  final BarcodeContent? currentBarcodeContent;
  final List<InventoryInfo>? _currentInventory;
  @override
  List<InventoryInfo>? get currentInventory {
    final value = _currentInventory;
    if (value == null) return null;
    if (_currentInventory is EqualUnmodifiableListView)
      return _currentInventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String scanContent;

  @override
  String toString() {
    return 'OutboundCollectState.scanProcessing(task: $task, taskItems: $taskItems, collectRecords: $collectRecords, currentTabIndex: $currentTabIndex, currentScanStep: $currentScanStep, userId: $userId, workStation: $workStation, currentSiteCode: $currentSiteCode, currentBarcodeContent: $currentBarcodeContent, currentInventory: $currentInventory, scanContent: $scanContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectScanProcessingImpl &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._collectRecords,
              _collectRecords,
            ) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.currentScanStep, currentScanStep) ||
                other.currentScanStep == currentScanStep) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.currentSiteCode, currentSiteCode) ||
                other.currentSiteCode == currentSiteCode) &&
            (identical(other.currentBarcodeContent, currentBarcodeContent) ||
                other.currentBarcodeContent == currentBarcodeContent) &&
            const DeepCollectionEquality().equals(
              other._currentInventory,
              _currentInventory,
            ) &&
            (identical(other.scanContent, scanContent) ||
                other.scanContent == scanContent));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    task,
    const DeepCollectionEquality().hash(_taskItems),
    const DeepCollectionEquality().hash(_collectRecords),
    currentTabIndex,
    currentScanStep,
    userId,
    workStation,
    currentSiteCode,
    currentBarcodeContent,
    const DeepCollectionEquality().hash(_currentInventory),
    scanContent,
  );

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundCollectScanProcessingImplCopyWith<
    _$OutboundCollectScanProcessingImpl
  >
  get copyWith =>
      __$$OutboundCollectScanProcessingImplCopyWithImpl<
        _$OutboundCollectScanProcessingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return scanProcessing(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
      scanContent,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return scanProcessing?.call(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
      scanContent,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (scanProcessing != null) {
      return scanProcessing(
        task,
        taskItems,
        collectRecords,
        currentTabIndex,
        currentScanStep,
        userId,
        workStation,
        currentSiteCode,
        currentBarcodeContent,
        currentInventory,
        scanContent,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return scanProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return scanProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (scanProcessing != null) {
      return scanProcessing(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectScanProcessing implements OutboundCollectState {
  const factory OutboundCollectScanProcessing({
    required final OutboundTask task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required final int currentTabIndex,
    required final ScanStep currentScanStep,
    required final String userId,
    required final String workStation,
    final String? currentSiteCode,
    final BarcodeContent? currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
    required final String scanContent,
  }) = _$OutboundCollectScanProcessingImpl;

  OutboundTask get task;
  List<OutboundTaskItem> get taskItems;
  List<CollectRecord> get collectRecords;
  int get currentTabIndex;
  ScanStep get currentScanStep;
  String get userId;
  String get workStation;
  String? get currentSiteCode;
  BarcodeContent? get currentBarcodeContent;
  List<InventoryInfo>? get currentInventory;
  String get scanContent;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboundCollectScanProcessingImplCopyWith<
    _$OutboundCollectScanProcessingImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutboundCollectInventoryQueryingImplCopyWith<$Res> {
  factory _$$OutboundCollectInventoryQueryingImplCopyWith(
    _$OutboundCollectInventoryQueryingImpl value,
    $Res Function(_$OutboundCollectInventoryQueryingImpl) then,
  ) = __$$OutboundCollectInventoryQueryingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    OutboundTask task,
    List<OutboundTaskItem> taskItems,
    List<CollectRecord> collectRecords,
    int currentTabIndex,
    ScanStep currentScanStep,
    String userId,
    String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    InventoryQuery query,
  });

  $OutboundTaskCopyWith<$Res> get task;
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent;
  $InventoryQueryCopyWith<$Res> get query;
}

/// @nodoc
class __$$OutboundCollectInventoryQueryingImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<
          $Res,
          _$OutboundCollectInventoryQueryingImpl
        >
    implements _$$OutboundCollectInventoryQueryingImplCopyWith<$Res> {
  __$$OutboundCollectInventoryQueryingImplCopyWithImpl(
    _$OutboundCollectInventoryQueryingImpl _value,
    $Res Function(_$OutboundCollectInventoryQueryingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? taskItems = null,
    Object? collectRecords = null,
    Object? currentTabIndex = null,
    Object? currentScanStep = null,
    Object? userId = null,
    Object? workStation = null,
    Object? currentSiteCode = freezed,
    Object? currentBarcodeContent = freezed,
    Object? query = null,
  }) {
    return _then(
      _$OutboundCollectInventoryQueryingImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask,
        taskItems: null == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<OutboundTaskItem>,
        collectRecords: null == collectRecords
            ? _value._collectRecords
            : collectRecords // ignore: cast_nullable_to_non_nullable
                  as List<CollectRecord>,
        currentTabIndex: null == currentTabIndex
            ? _value.currentTabIndex
            : currentTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentScanStep: null == currentScanStep
            ? _value.currentScanStep
            : currentScanStep // ignore: cast_nullable_to_non_nullable
                  as ScanStep,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        workStation: null == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String,
        currentSiteCode: freezed == currentSiteCode
            ? _value.currentSiteCode
            : currentSiteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBarcodeContent: freezed == currentBarcodeContent
            ? _value.currentBarcodeContent
            : currentBarcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent?,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as InventoryQuery,
      ),
    );
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res> get task {
    return $OutboundTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent {
    if (_value.currentBarcodeContent == null) {
      return null;
    }

    return $BarcodeContentCopyWith<$Res>(_value.currentBarcodeContent!, (
      value,
    ) {
      return _then(_value.copyWith(currentBarcodeContent: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InventoryQueryCopyWith<$Res> get query {
    return $InventoryQueryCopyWith<$Res>(_value.query, (value) {
      return _then(_value.copyWith(query: value));
    });
  }
}

/// @nodoc

class _$OutboundCollectInventoryQueryingImpl
    implements OutboundCollectInventoryQuerying {
  const _$OutboundCollectInventoryQueryingImpl({
    required this.task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required this.currentTabIndex,
    required this.currentScanStep,
    required this.userId,
    required this.workStation,
    this.currentSiteCode,
    this.currentBarcodeContent,
    required this.query,
  }) : _taskItems = taskItems,
       _collectRecords = collectRecords;

  @override
  final OutboundTask task;
  final List<OutboundTaskItem> _taskItems;
  @override
  List<OutboundTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  final List<CollectRecord> _collectRecords;
  @override
  List<CollectRecord> get collectRecords {
    if (_collectRecords is EqualUnmodifiableListView) return _collectRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectRecords);
  }

  @override
  final int currentTabIndex;
  @override
  final ScanStep currentScanStep;
  @override
  final String userId;
  @override
  final String workStation;
  @override
  final String? currentSiteCode;
  @override
  final BarcodeContent? currentBarcodeContent;
  @override
  final InventoryQuery query;

  @override
  String toString() {
    return 'OutboundCollectState.inventoryQuerying(task: $task, taskItems: $taskItems, collectRecords: $collectRecords, currentTabIndex: $currentTabIndex, currentScanStep: $currentScanStep, userId: $userId, workStation: $workStation, currentSiteCode: $currentSiteCode, currentBarcodeContent: $currentBarcodeContent, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectInventoryQueryingImpl &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._collectRecords,
              _collectRecords,
            ) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.currentScanStep, currentScanStep) ||
                other.currentScanStep == currentScanStep) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.currentSiteCode, currentSiteCode) ||
                other.currentSiteCode == currentSiteCode) &&
            (identical(other.currentBarcodeContent, currentBarcodeContent) ||
                other.currentBarcodeContent == currentBarcodeContent) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    task,
    const DeepCollectionEquality().hash(_taskItems),
    const DeepCollectionEquality().hash(_collectRecords),
    currentTabIndex,
    currentScanStep,
    userId,
    workStation,
    currentSiteCode,
    currentBarcodeContent,
    query,
  );

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundCollectInventoryQueryingImplCopyWith<
    _$OutboundCollectInventoryQueryingImpl
  >
  get copyWith =>
      __$$OutboundCollectInventoryQueryingImplCopyWithImpl<
        _$OutboundCollectInventoryQueryingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return inventoryQuerying(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      query,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return inventoryQuerying?.call(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      query,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (inventoryQuerying != null) {
      return inventoryQuerying(
        task,
        taskItems,
        collectRecords,
        currentTabIndex,
        currentScanStep,
        userId,
        workStation,
        currentSiteCode,
        currentBarcodeContent,
        query,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return inventoryQuerying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return inventoryQuerying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (inventoryQuerying != null) {
      return inventoryQuerying(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectInventoryQuerying
    implements OutboundCollectState {
  const factory OutboundCollectInventoryQuerying({
    required final OutboundTask task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required final int currentTabIndex,
    required final ScanStep currentScanStep,
    required final String userId,
    required final String workStation,
    final String? currentSiteCode,
    final BarcodeContent? currentBarcodeContent,
    required final InventoryQuery query,
  }) = _$OutboundCollectInventoryQueryingImpl;

  OutboundTask get task;
  List<OutboundTaskItem> get taskItems;
  List<CollectRecord> get collectRecords;
  int get currentTabIndex;
  ScanStep get currentScanStep;
  String get userId;
  String get workStation;
  String? get currentSiteCode;
  BarcodeContent? get currentBarcodeContent;
  InventoryQuery get query;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboundCollectInventoryQueryingImplCopyWith<
    _$OutboundCollectInventoryQueryingImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutboundCollectSubmittingImplCopyWith<$Res> {
  factory _$$OutboundCollectSubmittingImplCopyWith(
    _$OutboundCollectSubmittingImpl value,
    $Res Function(_$OutboundCollectSubmittingImpl) then,
  ) = __$$OutboundCollectSubmittingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    OutboundTask task,
    List<OutboundTaskItem> taskItems,
    List<CollectRecord> collectRecords,
    int currentTabIndex,
    ScanStep currentScanStep,
    String userId,
    String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
  });

  $OutboundTaskCopyWith<$Res> get task;
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent;
}

/// @nodoc
class __$$OutboundCollectSubmittingImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectStateCopyWithImpl<
          $Res,
          _$OutboundCollectSubmittingImpl
        >
    implements _$$OutboundCollectSubmittingImplCopyWith<$Res> {
  __$$OutboundCollectSubmittingImplCopyWithImpl(
    _$OutboundCollectSubmittingImpl _value,
    $Res Function(_$OutboundCollectSubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? taskItems = null,
    Object? collectRecords = null,
    Object? currentTabIndex = null,
    Object? currentScanStep = null,
    Object? userId = null,
    Object? workStation = null,
    Object? currentSiteCode = freezed,
    Object? currentBarcodeContent = freezed,
    Object? currentInventory = freezed,
  }) {
    return _then(
      _$OutboundCollectSubmittingImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask,
        taskItems: null == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<OutboundTaskItem>,
        collectRecords: null == collectRecords
            ? _value._collectRecords
            : collectRecords // ignore: cast_nullable_to_non_nullable
                  as List<CollectRecord>,
        currentTabIndex: null == currentTabIndex
            ? _value.currentTabIndex
            : currentTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentScanStep: null == currentScanStep
            ? _value.currentScanStep
            : currentScanStep // ignore: cast_nullable_to_non_nullable
                  as ScanStep,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        workStation: null == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String,
        currentSiteCode: freezed == currentSiteCode
            ? _value.currentSiteCode
            : currentSiteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBarcodeContent: freezed == currentBarcodeContent
            ? _value.currentBarcodeContent
            : currentBarcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent?,
        currentInventory: freezed == currentInventory
            ? _value._currentInventory
            : currentInventory // ignore: cast_nullable_to_non_nullable
                  as List<InventoryInfo>?,
      ),
    );
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res> get task {
    return $OutboundTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent {
    if (_value.currentBarcodeContent == null) {
      return null;
    }

    return $BarcodeContentCopyWith<$Res>(_value.currentBarcodeContent!, (
      value,
    ) {
      return _then(_value.copyWith(currentBarcodeContent: value));
    });
  }
}

/// @nodoc

class _$OutboundCollectSubmittingImpl implements OutboundCollectSubmitting {
  const _$OutboundCollectSubmittingImpl({
    required this.task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required this.currentTabIndex,
    required this.currentScanStep,
    required this.userId,
    required this.workStation,
    this.currentSiteCode,
    this.currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
  }) : _taskItems = taskItems,
       _collectRecords = collectRecords,
       _currentInventory = currentInventory;

  @override
  final OutboundTask task;
  final List<OutboundTaskItem> _taskItems;
  @override
  List<OutboundTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  final List<CollectRecord> _collectRecords;
  @override
  List<CollectRecord> get collectRecords {
    if (_collectRecords is EqualUnmodifiableListView) return _collectRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectRecords);
  }

  @override
  final int currentTabIndex;
  @override
  final ScanStep currentScanStep;
  @override
  final String userId;
  @override
  final String workStation;
  @override
  final String? currentSiteCode;
  @override
  final BarcodeContent? currentBarcodeContent;
  final List<InventoryInfo>? _currentInventory;
  @override
  List<InventoryInfo>? get currentInventory {
    final value = _currentInventory;
    if (value == null) return null;
    if (_currentInventory is EqualUnmodifiableListView)
      return _currentInventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OutboundCollectState.submitting(task: $task, taskItems: $taskItems, collectRecords: $collectRecords, currentTabIndex: $currentTabIndex, currentScanStep: $currentScanStep, userId: $userId, workStation: $workStation, currentSiteCode: $currentSiteCode, currentBarcodeContent: $currentBarcodeContent, currentInventory: $currentInventory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectSubmittingImpl &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._collectRecords,
              _collectRecords,
            ) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.currentScanStep, currentScanStep) ||
                other.currentScanStep == currentScanStep) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.currentSiteCode, currentSiteCode) ||
                other.currentSiteCode == currentSiteCode) &&
            (identical(other.currentBarcodeContent, currentBarcodeContent) ||
                other.currentBarcodeContent == currentBarcodeContent) &&
            const DeepCollectionEquality().equals(
              other._currentInventory,
              _currentInventory,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    task,
    const DeepCollectionEquality().hash(_taskItems),
    const DeepCollectionEquality().hash(_collectRecords),
    currentTabIndex,
    currentScanStep,
    userId,
    workStation,
    currentSiteCode,
    currentBarcodeContent,
    const DeepCollectionEquality().hash(_currentInventory),
  );

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundCollectSubmittingImplCopyWith<_$OutboundCollectSubmittingImpl>
  get copyWith =>
      __$$OutboundCollectSubmittingImplCopyWithImpl<
        _$OutboundCollectSubmittingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return submitting(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return submitting?.call(
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(
        task,
        taskItems,
        collectRecords,
        currentTabIndex,
        currentScanStep,
        userId,
        workStation,
        currentSiteCode,
        currentBarcodeContent,
        currentInventory,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectSubmitting implements OutboundCollectState {
  const factory OutboundCollectSubmitting({
    required final OutboundTask task,
    required final List<OutboundTaskItem> taskItems,
    required final List<CollectRecord> collectRecords,
    required final int currentTabIndex,
    required final ScanStep currentScanStep,
    required final String userId,
    required final String workStation,
    final String? currentSiteCode,
    final BarcodeContent? currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
  }) = _$OutboundCollectSubmittingImpl;

  OutboundTask get task;
  List<OutboundTaskItem> get taskItems;
  List<CollectRecord> get collectRecords;
  int get currentTabIndex;
  ScanStep get currentScanStep;
  String get userId;
  String get workStation;
  String? get currentSiteCode;
  BarcodeContent? get currentBarcodeContent;
  List<InventoryInfo>? get currentInventory;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboundCollectSubmittingImplCopyWith<_$OutboundCollectSubmittingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutboundCollectErrorImplCopyWith<$Res> {
  factory _$$OutboundCollectErrorImplCopyWith(
    _$OutboundCollectErrorImpl value,
    $Res Function(_$OutboundCollectErrorImpl) then,
  ) = __$$OutboundCollectErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    OutboundTask? task,
    List<OutboundTaskItem>? taskItems,
    List<CollectRecord>? collectRecords,
    int? currentTabIndex,
    ScanStep? currentScanStep,
    String? userId,
    String? workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
  });

  $OutboundTaskCopyWith<$Res>? get task;
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent;
}

/// @nodoc
class __$$OutboundCollectErrorImplCopyWithImpl<$Res>
    extends _$OutboundCollectStateCopyWithImpl<$Res, _$OutboundCollectErrorImpl>
    implements _$$OutboundCollectErrorImplCopyWith<$Res> {
  __$$OutboundCollectErrorImplCopyWithImpl(
    _$OutboundCollectErrorImpl _value,
    $Res Function(_$OutboundCollectErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? task = freezed,
    Object? taskItems = freezed,
    Object? collectRecords = freezed,
    Object? currentTabIndex = freezed,
    Object? currentScanStep = freezed,
    Object? userId = freezed,
    Object? workStation = freezed,
    Object? currentSiteCode = freezed,
    Object? currentBarcodeContent = freezed,
    Object? currentInventory = freezed,
  }) {
    return _then(
      _$OutboundCollectErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        task: freezed == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask?,
        taskItems: freezed == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<OutboundTaskItem>?,
        collectRecords: freezed == collectRecords
            ? _value._collectRecords
            : collectRecords // ignore: cast_nullable_to_non_nullable
                  as List<CollectRecord>?,
        currentTabIndex: freezed == currentTabIndex
            ? _value.currentTabIndex
            : currentTabIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentScanStep: freezed == currentScanStep
            ? _value.currentScanStep
            : currentScanStep // ignore: cast_nullable_to_non_nullable
                  as ScanStep?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        workStation: freezed == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentSiteCode: freezed == currentSiteCode
            ? _value.currentSiteCode
            : currentSiteCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBarcodeContent: freezed == currentBarcodeContent
            ? _value.currentBarcodeContent
            : currentBarcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent?,
        currentInventory: freezed == currentInventory
            ? _value._currentInventory
            : currentInventory // ignore: cast_nullable_to_non_nullable
                  as List<InventoryInfo>?,
      ),
    );
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res>? get task {
    if (_value.task == null) {
      return null;
    }

    return $OutboundTaskCopyWith<$Res>(_value.task!, (value) {
      return _then(_value.copyWith(task: value));
    });
  }

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res>? get currentBarcodeContent {
    if (_value.currentBarcodeContent == null) {
      return null;
    }

    return $BarcodeContentCopyWith<$Res>(_value.currentBarcodeContent!, (
      value,
    ) {
      return _then(_value.copyWith(currentBarcodeContent: value));
    });
  }
}

/// @nodoc

class _$OutboundCollectErrorImpl implements OutboundCollectError {
  const _$OutboundCollectErrorImpl({
    required this.message,
    this.task,
    final List<OutboundTaskItem>? taskItems,
    final List<CollectRecord>? collectRecords,
    this.currentTabIndex,
    this.currentScanStep,
    this.userId,
    this.workStation,
    this.currentSiteCode,
    this.currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
  }) : _taskItems = taskItems,
       _collectRecords = collectRecords,
       _currentInventory = currentInventory;

  @override
  final String message;
  @override
  final OutboundTask? task;
  final List<OutboundTaskItem>? _taskItems;
  @override
  List<OutboundTaskItem>? get taskItems {
    final value = _taskItems;
    if (value == null) return null;
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CollectRecord>? _collectRecords;
  @override
  List<CollectRecord>? get collectRecords {
    final value = _collectRecords;
    if (value == null) return null;
    if (_collectRecords is EqualUnmodifiableListView) return _collectRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? currentTabIndex;
  @override
  final ScanStep? currentScanStep;
  @override
  final String? userId;
  @override
  final String? workStation;
  @override
  final String? currentSiteCode;
  @override
  final BarcodeContent? currentBarcodeContent;
  final List<InventoryInfo>? _currentInventory;
  @override
  List<InventoryInfo>? get currentInventory {
    final value = _currentInventory;
    if (value == null) return null;
    if (_currentInventory is EqualUnmodifiableListView)
      return _currentInventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OutboundCollectState.error(message: $message, task: $task, taskItems: $taskItems, collectRecords: $collectRecords, currentTabIndex: $currentTabIndex, currentScanStep: $currentScanStep, userId: $userId, workStation: $workStation, currentSiteCode: $currentSiteCode, currentBarcodeContent: $currentBarcodeContent, currentInventory: $currentInventory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundCollectErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.task, task) || other.task == task) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._collectRecords,
              _collectRecords,
            ) &&
            (identical(other.currentTabIndex, currentTabIndex) ||
                other.currentTabIndex == currentTabIndex) &&
            (identical(other.currentScanStep, currentScanStep) ||
                other.currentScanStep == currentScanStep) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.currentSiteCode, currentSiteCode) ||
                other.currentSiteCode == currentSiteCode) &&
            (identical(other.currentBarcodeContent, currentBarcodeContent) ||
                other.currentBarcodeContent == currentBarcodeContent) &&
            const DeepCollectionEquality().equals(
              other._currentInventory,
              _currentInventory,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    task,
    const DeepCollectionEquality().hash(_taskItems),
    const DeepCollectionEquality().hash(_collectRecords),
    currentTabIndex,
    currentScanStep,
    userId,
    workStation,
    currentSiteCode,
    currentBarcodeContent,
    const DeepCollectionEquality().hash(_currentInventory),
  );

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundCollectErrorImplCopyWith<_$OutboundCollectErrorImpl>
  get copyWith =>
      __$$OutboundCollectErrorImplCopyWithImpl<_$OutboundCollectErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )
    loaded,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )
    scanProcessing,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )
    inventoryQuerying,
    required TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    submitting,
    required TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )
    error,
  }) {
    return error(
      message,
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult? Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult? Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
  }) {
    return error?.call(
      message,
      task,
      taskItems,
      collectRecords,
      currentTabIndex,
      currentScanStep,
      userId,
      workStation,
      currentSiteCode,
      currentBarcodeContent,
      currentInventory,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      bool isSubmitting,
      bool isValidating,
      String? errorMessage,
      String? successMessage,
    )?
    loaded,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
      String scanContent,
    )?
    scanProcessing,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      InventoryQuery query,
    )?
    inventoryQuerying,
    TResult Function(
      OutboundTask task,
      List<OutboundTaskItem> taskItems,
      List<CollectRecord> collectRecords,
      int currentTabIndex,
      ScanStep currentScanStep,
      String userId,
      String workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    submitting,
    TResult Function(
      String message,
      OutboundTask? task,
      List<OutboundTaskItem>? taskItems,
      List<CollectRecord>? collectRecords,
      int? currentTabIndex,
      ScanStep? currentScanStep,
      String? userId,
      String? workStation,
      String? currentSiteCode,
      BarcodeContent? currentBarcodeContent,
      List<InventoryInfo>? currentInventory,
    )?
    error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(
        message,
        task,
        taskItems,
        collectRecords,
        currentTabIndex,
        currentScanStep,
        userId,
        workStation,
        currentSiteCode,
        currentBarcodeContent,
        currentInventory,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OutboundCollectInitial value) initial,
    required TResult Function(OutboundCollectLoading value) loading,
    required TResult Function(OutboundCollectLoaded value) loaded,
    required TResult Function(OutboundCollectScanProcessing value)
    scanProcessing,
    required TResult Function(OutboundCollectInventoryQuerying value)
    inventoryQuerying,
    required TResult Function(OutboundCollectSubmitting value) submitting,
    required TResult Function(OutboundCollectError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OutboundCollectInitial value)? initial,
    TResult? Function(OutboundCollectLoading value)? loading,
    TResult? Function(OutboundCollectLoaded value)? loaded,
    TResult? Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult? Function(OutboundCollectInventoryQuerying value)?
    inventoryQuerying,
    TResult? Function(OutboundCollectSubmitting value)? submitting,
    TResult? Function(OutboundCollectError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OutboundCollectInitial value)? initial,
    TResult Function(OutboundCollectLoading value)? loading,
    TResult Function(OutboundCollectLoaded value)? loaded,
    TResult Function(OutboundCollectScanProcessing value)? scanProcessing,
    TResult Function(OutboundCollectInventoryQuerying value)? inventoryQuerying,
    TResult Function(OutboundCollectSubmitting value)? submitting,
    TResult Function(OutboundCollectError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OutboundCollectError implements OutboundCollectState {
  const factory OutboundCollectError({
    required final String message,
    final OutboundTask? task,
    final List<OutboundTaskItem>? taskItems,
    final List<CollectRecord>? collectRecords,
    final int? currentTabIndex,
    final ScanStep? currentScanStep,
    final String? userId,
    final String? workStation,
    final String? currentSiteCode,
    final BarcodeContent? currentBarcodeContent,
    final List<InventoryInfo>? currentInventory,
  }) = _$OutboundCollectErrorImpl;

  String get message;
  OutboundTask? get task;
  List<OutboundTaskItem>? get taskItems;
  List<CollectRecord>? get collectRecords;
  int? get currentTabIndex;
  ScanStep? get currentScanStep;
  String? get userId;
  String? get workStation;
  String? get currentSiteCode;
  BarcodeContent? get currentBarcodeContent;
  List<InventoryInfo>? get currentInventory;

  /// Create a copy of OutboundCollectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboundCollectErrorImplCopyWith<_$OutboundCollectErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
