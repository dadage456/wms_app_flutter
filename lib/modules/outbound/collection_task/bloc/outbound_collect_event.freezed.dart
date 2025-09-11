// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_collect_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OutboundCollectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundCollectEventCopyWith<$Res> {
  factory $OutboundCollectEventCopyWith(
    OutboundCollectEvent value,
    $Res Function(OutboundCollectEvent) then,
  ) = _$OutboundCollectEventCopyWithImpl<$Res, OutboundCollectEvent>;
}

/// @nodoc
class _$OutboundCollectEventCopyWithImpl<
  $Res,
  $Val extends OutboundCollectEvent
>
    implements $OutboundCollectEventCopyWith<$Res> {
  _$OutboundCollectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializeCollectEventImplCopyWith<$Res> {
  factory _$$InitializeCollectEventImplCopyWith(
    _$InitializeCollectEventImpl value,
    $Res Function(_$InitializeCollectEventImpl) then,
  ) = __$$InitializeCollectEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutboundTask task, String userId, String workStation});

  $OutboundTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$InitializeCollectEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$InitializeCollectEventImpl>
    implements _$$InitializeCollectEventImplCopyWith<$Res> {
  __$$InitializeCollectEventImplCopyWithImpl(
    _$InitializeCollectEventImpl _value,
    $Res Function(_$InitializeCollectEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? userId = null,
    Object? workStation = null,
  }) {
    return _then(
      _$InitializeCollectEventImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as OutboundTask,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        workStation: null == workStation
            ? _value.workStation
            : workStation // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskCopyWith<$Res> get task {
    return $OutboundTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$InitializeCollectEventImpl implements InitializeCollectEvent {
  const _$InitializeCollectEventImpl({
    required this.task,
    required this.userId,
    required this.workStation,
  });

  @override
  final OutboundTask task;
  @override
  final String userId;
  @override
  final String workStation;

  @override
  String toString() {
    return 'OutboundCollectEvent.initialize(task: $task, userId: $userId, workStation: $workStation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializeCollectEventImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task, userId, workStation);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializeCollectEventImplCopyWith<_$InitializeCollectEventImpl>
  get copyWith =>
      __$$InitializeCollectEventImplCopyWithImpl<_$InitializeCollectEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return initialize(task, userId, workStation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return initialize?.call(task, userId, workStation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(task, userId, workStation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }
}

abstract class InitializeCollectEvent implements OutboundCollectEvent {
  const factory InitializeCollectEvent({
    required final OutboundTask task,
    required final String userId,
    required final String workStation,
  }) = _$InitializeCollectEventImpl;

  OutboundTask get task;
  String get userId;
  String get workStation;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitializeCollectEventImplCopyWith<_$InitializeCollectEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadTaskItemsEventImplCopyWith<$Res> {
  factory _$$LoadTaskItemsEventImplCopyWith(
    _$LoadTaskItemsEventImpl value,
    $Res Function(_$LoadTaskItemsEventImpl) then,
  ) = __$$LoadTaskItemsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTaskItemsEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$LoadTaskItemsEventImpl>
    implements _$$LoadTaskItemsEventImplCopyWith<$Res> {
  __$$LoadTaskItemsEventImplCopyWithImpl(
    _$LoadTaskItemsEventImpl _value,
    $Res Function(_$LoadTaskItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTaskItemsEventImpl implements LoadTaskItemsEvent {
  const _$LoadTaskItemsEventImpl();

  @override
  String toString() {
    return 'OutboundCollectEvent.loadTaskItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadTaskItemsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return loadTaskItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return loadTaskItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (loadTaskItems != null) {
      return loadTaskItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return loadTaskItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return loadTaskItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (loadTaskItems != null) {
      return loadTaskItems(this);
    }
    return orElse();
  }
}

abstract class LoadTaskItemsEvent implements OutboundCollectEvent {
  const factory LoadTaskItemsEvent() = _$LoadTaskItemsEventImpl;
}

/// @nodoc
abstract class _$$RefreshTaskItemsEventImplCopyWith<$Res> {
  factory _$$RefreshTaskItemsEventImplCopyWith(
    _$RefreshTaskItemsEventImpl value,
    $Res Function(_$RefreshTaskItemsEventImpl) then,
  ) = __$$RefreshTaskItemsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshTaskItemsEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$RefreshTaskItemsEventImpl>
    implements _$$RefreshTaskItemsEventImplCopyWith<$Res> {
  __$$RefreshTaskItemsEventImplCopyWithImpl(
    _$RefreshTaskItemsEventImpl _value,
    $Res Function(_$RefreshTaskItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshTaskItemsEventImpl implements RefreshTaskItemsEvent {
  const _$RefreshTaskItemsEventImpl();

  @override
  String toString() {
    return 'OutboundCollectEvent.refreshTaskItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTaskItemsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return refreshTaskItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return refreshTaskItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (refreshTaskItems != null) {
      return refreshTaskItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return refreshTaskItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return refreshTaskItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (refreshTaskItems != null) {
      return refreshTaskItems(this);
    }
    return orElse();
  }
}

abstract class RefreshTaskItemsEvent implements OutboundCollectEvent {
  const factory RefreshTaskItemsEvent() = _$RefreshTaskItemsEventImpl;
}

/// @nodoc
abstract class _$$SearchTaskItemsEventImplCopyWith<$Res> {
  factory _$$SearchTaskItemsEventImplCopyWith(
    _$SearchTaskItemsEventImpl value,
    $Res Function(_$SearchTaskItemsEventImpl) then,
  ) = __$$SearchTaskItemsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String searchKey});
}

/// @nodoc
class __$$SearchTaskItemsEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$SearchTaskItemsEventImpl>
    implements _$$SearchTaskItemsEventImplCopyWith<$Res> {
  __$$SearchTaskItemsEventImplCopyWithImpl(
    _$SearchTaskItemsEventImpl _value,
    $Res Function(_$SearchTaskItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchKey = null}) {
    return _then(
      _$SearchTaskItemsEventImpl(
        searchKey: null == searchKey
            ? _value.searchKey
            : searchKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchTaskItemsEventImpl implements SearchTaskItemsEvent {
  const _$SearchTaskItemsEventImpl({required this.searchKey});

  @override
  final String searchKey;

  @override
  String toString() {
    return 'OutboundCollectEvent.searchTaskItems(searchKey: $searchKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTaskItemsEventImpl &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchKey);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTaskItemsEventImplCopyWith<_$SearchTaskItemsEventImpl>
  get copyWith =>
      __$$SearchTaskItemsEventImplCopyWithImpl<_$SearchTaskItemsEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return searchTaskItems(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return searchTaskItems?.call(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (searchTaskItems != null) {
      return searchTaskItems(searchKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return searchTaskItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return searchTaskItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (searchTaskItems != null) {
      return searchTaskItems(this);
    }
    return orElse();
  }
}

abstract class SearchTaskItemsEvent implements OutboundCollectEvent {
  const factory SearchTaskItemsEvent({required final String searchKey}) =
      _$SearchTaskItemsEventImpl;

  String get searchKey;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchTaskItemsEventImplCopyWith<_$SearchTaskItemsEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessScanCodeEventImplCopyWith<$Res> {
  factory _$$ProcessScanCodeEventImplCopyWith(
    _$ProcessScanCodeEventImpl value,
    $Res Function(_$ProcessScanCodeEventImpl) then,
  ) = __$$ProcessScanCodeEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$ProcessScanCodeEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$ProcessScanCodeEventImpl>
    implements _$$ProcessScanCodeEventImplCopyWith<$Res> {
  __$$ProcessScanCodeEventImplCopyWithImpl(
    _$ProcessScanCodeEventImpl _value,
    $Res Function(_$ProcessScanCodeEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? content = null}) {
    return _then(
      _$ProcessScanCodeEventImpl(
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProcessScanCodeEventImpl implements ProcessScanCodeEvent {
  const _$ProcessScanCodeEventImpl({required this.content});

  @override
  final String content;

  @override
  String toString() {
    return 'OutboundCollectEvent.processScanCode(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessScanCodeEventImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessScanCodeEventImplCopyWith<_$ProcessScanCodeEventImpl>
  get copyWith =>
      __$$ProcessScanCodeEventImplCopyWithImpl<_$ProcessScanCodeEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return processScanCode(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return processScanCode?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (processScanCode != null) {
      return processScanCode(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return processScanCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return processScanCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (processScanCode != null) {
      return processScanCode(this);
    }
    return orElse();
  }
}

abstract class ProcessScanCodeEvent implements OutboundCollectEvent {
  const factory ProcessScanCodeEvent({required final String content}) =
      _$ProcessScanCodeEventImpl;

  String get content;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessScanCodeEventImplCopyWith<_$ProcessScanCodeEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateSiteEventImplCopyWith<$Res> {
  factory _$$ValidateSiteEventImplCopyWith(
    _$ValidateSiteEventImpl value,
    $Res Function(_$ValidateSiteEventImpl) then,
  ) = __$$ValidateSiteEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String siteCode});
}

/// @nodoc
class __$$ValidateSiteEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$ValidateSiteEventImpl>
    implements _$$ValidateSiteEventImplCopyWith<$Res> {
  __$$ValidateSiteEventImplCopyWithImpl(
    _$ValidateSiteEventImpl _value,
    $Res Function(_$ValidateSiteEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? siteCode = null}) {
    return _then(
      _$ValidateSiteEventImpl(
        siteCode: null == siteCode
            ? _value.siteCode
            : siteCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ValidateSiteEventImpl implements ValidateSiteEvent {
  const _$ValidateSiteEventImpl({required this.siteCode});

  @override
  final String siteCode;

  @override
  String toString() {
    return 'OutboundCollectEvent.validateSite(siteCode: $siteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateSiteEventImpl &&
            (identical(other.siteCode, siteCode) ||
                other.siteCode == siteCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, siteCode);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateSiteEventImplCopyWith<_$ValidateSiteEventImpl> get copyWith =>
      __$$ValidateSiteEventImplCopyWithImpl<_$ValidateSiteEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return validateSite(siteCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return validateSite?.call(siteCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (validateSite != null) {
      return validateSite(siteCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return validateSite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return validateSite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (validateSite != null) {
      return validateSite(this);
    }
    return orElse();
  }
}

abstract class ValidateSiteEvent implements OutboundCollectEvent {
  const factory ValidateSiteEvent({required final String siteCode}) =
      _$ValidateSiteEventImpl;

  String get siteCode;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateSiteEventImplCopyWith<_$ValidateSiteEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateMaterialEventImplCopyWith<$Res> {
  factory _$$ValidateMaterialEventImplCopyWith(
    _$ValidateMaterialEventImpl value,
    $Res Function(_$ValidateMaterialEventImpl) then,
  ) = __$$ValidateMaterialEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BarcodeContent barcodeContent, String siteCode});

  $BarcodeContentCopyWith<$Res> get barcodeContent;
}

/// @nodoc
class __$$ValidateMaterialEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$ValidateMaterialEventImpl>
    implements _$$ValidateMaterialEventImplCopyWith<$Res> {
  __$$ValidateMaterialEventImplCopyWithImpl(
    _$ValidateMaterialEventImpl _value,
    $Res Function(_$ValidateMaterialEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? barcodeContent = null, Object? siteCode = null}) {
    return _then(
      _$ValidateMaterialEventImpl(
        barcodeContent: null == barcodeContent
            ? _value.barcodeContent
            : barcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent,
        siteCode: null == siteCode
            ? _value.siteCode
            : siteCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res> get barcodeContent {
    return $BarcodeContentCopyWith<$Res>(_value.barcodeContent, (value) {
      return _then(_value.copyWith(barcodeContent: value));
    });
  }
}

/// @nodoc

class _$ValidateMaterialEventImpl implements ValidateMaterialEvent {
  const _$ValidateMaterialEventImpl({
    required this.barcodeContent,
    required this.siteCode,
  });

  @override
  final BarcodeContent barcodeContent;
  @override
  final String siteCode;

  @override
  String toString() {
    return 'OutboundCollectEvent.validateMaterial(barcodeContent: $barcodeContent, siteCode: $siteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateMaterialEventImpl &&
            (identical(other.barcodeContent, barcodeContent) ||
                other.barcodeContent == barcodeContent) &&
            (identical(other.siteCode, siteCode) ||
                other.siteCode == siteCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, barcodeContent, siteCode);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateMaterialEventImplCopyWith<_$ValidateMaterialEventImpl>
  get copyWith =>
      __$$ValidateMaterialEventImplCopyWithImpl<_$ValidateMaterialEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return validateMaterial(barcodeContent, siteCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return validateMaterial?.call(barcodeContent, siteCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (validateMaterial != null) {
      return validateMaterial(barcodeContent, siteCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return validateMaterial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return validateMaterial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (validateMaterial != null) {
      return validateMaterial(this);
    }
    return orElse();
  }
}

abstract class ValidateMaterialEvent implements OutboundCollectEvent {
  const factory ValidateMaterialEvent({
    required final BarcodeContent barcodeContent,
    required final String siteCode,
  }) = _$ValidateMaterialEventImpl;

  BarcodeContent get barcodeContent;
  String get siteCode;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateMaterialEventImplCopyWith<_$ValidateMaterialEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueryInventoryEventImplCopyWith<$Res> {
  factory _$$QueryInventoryEventImplCopyWith(
    _$QueryInventoryEventImpl value,
    $Res Function(_$QueryInventoryEventImpl) then,
  ) = __$$QueryInventoryEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InventoryQuery query});

  $InventoryQueryCopyWith<$Res> get query;
}

/// @nodoc
class __$$QueryInventoryEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$QueryInventoryEventImpl>
    implements _$$QueryInventoryEventImplCopyWith<$Res> {
  __$$QueryInventoryEventImplCopyWithImpl(
    _$QueryInventoryEventImpl _value,
    $Res Function(_$QueryInventoryEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$QueryInventoryEventImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as InventoryQuery,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
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

class _$QueryInventoryEventImpl implements QueryInventoryEvent {
  const _$QueryInventoryEventImpl({required this.query});

  @override
  final InventoryQuery query;

  @override
  String toString() {
    return 'OutboundCollectEvent.queryInventory(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueryInventoryEventImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueryInventoryEventImplCopyWith<_$QueryInventoryEventImpl> get copyWith =>
      __$$QueryInventoryEventImplCopyWithImpl<_$QueryInventoryEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return queryInventory(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return queryInventory?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (queryInventory != null) {
      return queryInventory(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return queryInventory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return queryInventory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (queryInventory != null) {
      return queryInventory(this);
    }
    return orElse();
  }
}

abstract class QueryInventoryEvent implements OutboundCollectEvent {
  const factory QueryInventoryEvent({required final InventoryQuery query}) =
      _$QueryInventoryEventImpl;

  InventoryQuery get query;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueryInventoryEventImplCopyWith<_$QueryInventoryEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmQuantityEventImplCopyWith<$Res> {
  factory _$$ConfirmQuantityEventImplCopyWith(
    _$ConfirmQuantityEventImpl value,
    $Res Function(_$ConfirmQuantityEventImpl) then,
  ) = __$$ConfirmQuantityEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int quantity});
}

/// @nodoc
class __$$ConfirmQuantityEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$ConfirmQuantityEventImpl>
    implements _$$ConfirmQuantityEventImplCopyWith<$Res> {
  __$$ConfirmQuantityEventImplCopyWithImpl(
    _$ConfirmQuantityEventImpl _value,
    $Res Function(_$ConfirmQuantityEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quantity = null}) {
    return _then(
      _$ConfirmQuantityEventImpl(
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmQuantityEventImpl implements ConfirmQuantityEvent {
  const _$ConfirmQuantityEventImpl({required this.quantity});

  @override
  final int quantity;

  @override
  String toString() {
    return 'OutboundCollectEvent.confirmQuantity(quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmQuantityEventImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmQuantityEventImplCopyWith<_$ConfirmQuantityEventImpl>
  get copyWith =>
      __$$ConfirmQuantityEventImplCopyWithImpl<_$ConfirmQuantityEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return confirmQuantity(quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return confirmQuantity?.call(quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (confirmQuantity != null) {
      return confirmQuantity(quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return confirmQuantity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return confirmQuantity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (confirmQuantity != null) {
      return confirmQuantity(this);
    }
    return orElse();
  }
}

abstract class ConfirmQuantityEvent implements OutboundCollectEvent {
  const factory ConfirmQuantityEvent({required final int quantity}) =
      _$ConfirmQuantityEventImpl;

  int get quantity;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmQuantityEventImplCopyWith<_$ConfirmQuantityEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCollectRecordEventImplCopyWith<$Res> {
  factory _$$AddCollectRecordEventImplCopyWith(
    _$AddCollectRecordEventImpl value,
    $Res Function(_$AddCollectRecordEventImpl) then,
  ) = __$$AddCollectRecordEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CollectRecord record});

  $CollectRecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$AddCollectRecordEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$AddCollectRecordEventImpl>
    implements _$$AddCollectRecordEventImplCopyWith<$Res> {
  __$$AddCollectRecordEventImplCopyWithImpl(
    _$AddCollectRecordEventImpl _value,
    $Res Function(_$AddCollectRecordEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? record = null}) {
    return _then(
      _$AddCollectRecordEventImpl(
        record: null == record
            ? _value.record
            : record // ignore: cast_nullable_to_non_nullable
                  as CollectRecord,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectRecordCopyWith<$Res> get record {
    return $CollectRecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value));
    });
  }
}

/// @nodoc

class _$AddCollectRecordEventImpl implements AddCollectRecordEvent {
  const _$AddCollectRecordEventImpl({required this.record});

  @override
  final CollectRecord record;

  @override
  String toString() {
    return 'OutboundCollectEvent.addCollectRecord(record: $record)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCollectRecordEventImpl &&
            (identical(other.record, record) || other.record == record));
  }

  @override
  int get hashCode => Object.hash(runtimeType, record);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCollectRecordEventImplCopyWith<_$AddCollectRecordEventImpl>
  get copyWith =>
      __$$AddCollectRecordEventImplCopyWithImpl<_$AddCollectRecordEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return addCollectRecord(record);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return addCollectRecord?.call(record);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (addCollectRecord != null) {
      return addCollectRecord(record);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return addCollectRecord(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return addCollectRecord?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (addCollectRecord != null) {
      return addCollectRecord(this);
    }
    return orElse();
  }
}

abstract class AddCollectRecordEvent implements OutboundCollectEvent {
  const factory AddCollectRecordEvent({required final CollectRecord record}) =
      _$AddCollectRecordEventImpl;

  CollectRecord get record;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCollectRecordEventImplCopyWith<_$AddCollectRecordEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveCollectRecordEventImplCopyWith<$Res> {
  factory _$$RemoveCollectRecordEventImplCopyWith(
    _$RemoveCollectRecordEventImpl value,
    $Res Function(_$RemoveCollectRecordEventImpl) then,
  ) = __$$RemoveCollectRecordEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$RemoveCollectRecordEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$RemoveCollectRecordEventImpl>
    implements _$$RemoveCollectRecordEventImplCopyWith<$Res> {
  __$$RemoveCollectRecordEventImplCopyWithImpl(
    _$RemoveCollectRecordEventImpl _value,
    $Res Function(_$RemoveCollectRecordEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null}) {
    return _then(
      _$RemoveCollectRecordEventImpl(
        index: null == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RemoveCollectRecordEventImpl implements RemoveCollectRecordEvent {
  const _$RemoveCollectRecordEventImpl({required this.index});

  @override
  final int index;

  @override
  String toString() {
    return 'OutboundCollectEvent.removeCollectRecord(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveCollectRecordEventImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveCollectRecordEventImplCopyWith<_$RemoveCollectRecordEventImpl>
  get copyWith =>
      __$$RemoveCollectRecordEventImplCopyWithImpl<
        _$RemoveCollectRecordEventImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return removeCollectRecord(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return removeCollectRecord?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (removeCollectRecord != null) {
      return removeCollectRecord(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return removeCollectRecord(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return removeCollectRecord?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (removeCollectRecord != null) {
      return removeCollectRecord(this);
    }
    return orElse();
  }
}

abstract class RemoveCollectRecordEvent implements OutboundCollectEvent {
  const factory RemoveCollectRecordEvent({required final int index}) =
      _$RemoveCollectRecordEventImpl;

  int get index;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveCollectRecordEventImplCopyWith<_$RemoveCollectRecordEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearCollectRecordsEventImplCopyWith<$Res> {
  factory _$$ClearCollectRecordsEventImplCopyWith(
    _$ClearCollectRecordsEventImpl value,
    $Res Function(_$ClearCollectRecordsEventImpl) then,
  ) = __$$ClearCollectRecordsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCollectRecordsEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$ClearCollectRecordsEventImpl>
    implements _$$ClearCollectRecordsEventImplCopyWith<$Res> {
  __$$ClearCollectRecordsEventImplCopyWithImpl(
    _$ClearCollectRecordsEventImpl _value,
    $Res Function(_$ClearCollectRecordsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearCollectRecordsEventImpl implements ClearCollectRecordsEvent {
  const _$ClearCollectRecordsEventImpl();

  @override
  String toString() {
    return 'OutboundCollectEvent.clearCollectRecords()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearCollectRecordsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return clearCollectRecords();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return clearCollectRecords?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (clearCollectRecords != null) {
      return clearCollectRecords();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return clearCollectRecords(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return clearCollectRecords?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (clearCollectRecords != null) {
      return clearCollectRecords(this);
    }
    return orElse();
  }
}

abstract class ClearCollectRecordsEvent implements OutboundCollectEvent {
  const factory ClearCollectRecordsEvent() = _$ClearCollectRecordsEventImpl;
}

/// @nodoc
abstract class _$$SubmitCollectDataEventImplCopyWith<$Res> {
  factory _$$SubmitCollectDataEventImplCopyWith(
    _$SubmitCollectDataEventImpl value,
    $Res Function(_$SubmitCollectDataEventImpl) then,
  ) = __$$SubmitCollectDataEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitCollectDataEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$SubmitCollectDataEventImpl>
    implements _$$SubmitCollectDataEventImplCopyWith<$Res> {
  __$$SubmitCollectDataEventImplCopyWithImpl(
    _$SubmitCollectDataEventImpl _value,
    $Res Function(_$SubmitCollectDataEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitCollectDataEventImpl implements SubmitCollectDataEvent {
  const _$SubmitCollectDataEventImpl();

  @override
  String toString() {
    return 'OutboundCollectEvent.submitCollectData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitCollectDataEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return submitCollectData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return submitCollectData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (submitCollectData != null) {
      return submitCollectData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return submitCollectData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return submitCollectData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (submitCollectData != null) {
      return submitCollectData(this);
    }
    return orElse();
  }
}

abstract class SubmitCollectDataEvent implements OutboundCollectEvent {
  const factory SubmitCollectDataEvent() = _$SubmitCollectDataEventImpl;
}

/// @nodoc
abstract class _$$ReportShortageEventImplCopyWith<$Res> {
  factory _$$ReportShortageEventImplCopyWith(
    _$ReportShortageEventImpl value,
    $Res Function(_$ReportShortageEventImpl) then,
  ) = __$$ReportShortageEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String outTaskItemId});
}

/// @nodoc
class __$$ReportShortageEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$ReportShortageEventImpl>
    implements _$$ReportShortageEventImplCopyWith<$Res> {
  __$$ReportShortageEventImplCopyWithImpl(
    _$ReportShortageEventImpl _value,
    $Res Function(_$ReportShortageEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? outTaskItemId = null}) {
    return _then(
      _$ReportShortageEventImpl(
        outTaskItemId: null == outTaskItemId
            ? _value.outTaskItemId
            : outTaskItemId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ReportShortageEventImpl implements ReportShortageEvent {
  const _$ReportShortageEventImpl({required this.outTaskItemId});

  @override
  final String outTaskItemId;

  @override
  String toString() {
    return 'OutboundCollectEvent.reportShortage(outTaskItemId: $outTaskItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportShortageEventImpl &&
            (identical(other.outTaskItemId, outTaskItemId) ||
                other.outTaskItemId == outTaskItemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outTaskItemId);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportShortageEventImplCopyWith<_$ReportShortageEventImpl> get copyWith =>
      __$$ReportShortageEventImplCopyWithImpl<_$ReportShortageEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return reportShortage(outTaskItemId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return reportShortage?.call(outTaskItemId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (reportShortage != null) {
      return reportShortage(outTaskItemId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return reportShortage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return reportShortage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (reportShortage != null) {
      return reportShortage(this);
    }
    return orElse();
  }
}

abstract class ReportShortageEvent implements OutboundCollectEvent {
  const factory ReportShortageEvent({required final String outTaskItemId}) =
      _$ReportShortageEventImpl;

  String get outTaskItemId;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportShortageEventImplCopyWith<_$ReportShortageEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SwitchTabEventImplCopyWith<$Res> {
  factory _$$SwitchTabEventImplCopyWith(
    _$SwitchTabEventImpl value,
    $Res Function(_$SwitchTabEventImpl) then,
  ) = __$$SwitchTabEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int tabIndex});
}

/// @nodoc
class __$$SwitchTabEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$SwitchTabEventImpl>
    implements _$$SwitchTabEventImplCopyWith<$Res> {
  __$$SwitchTabEventImplCopyWithImpl(
    _$SwitchTabEventImpl _value,
    $Res Function(_$SwitchTabEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tabIndex = null}) {
    return _then(
      _$SwitchTabEventImpl(
        tabIndex: null == tabIndex
            ? _value.tabIndex
            : tabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SwitchTabEventImpl implements SwitchTabEvent {
  const _$SwitchTabEventImpl({required this.tabIndex});

  @override
  final int tabIndex;

  @override
  String toString() {
    return 'OutboundCollectEvent.switchTab(tabIndex: $tabIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwitchTabEventImpl &&
            (identical(other.tabIndex, tabIndex) ||
                other.tabIndex == tabIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tabIndex);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SwitchTabEventImplCopyWith<_$SwitchTabEventImpl> get copyWith =>
      __$$SwitchTabEventImplCopyWithImpl<_$SwitchTabEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return switchTab(tabIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return switchTab?.call(tabIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(tabIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return switchTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return switchTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (switchTab != null) {
      return switchTab(this);
    }
    return orElse();
  }
}

abstract class SwitchTabEvent implements OutboundCollectEvent {
  const factory SwitchTabEvent({required final int tabIndex}) =
      _$SwitchTabEventImpl;

  int get tabIndex;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SwitchTabEventImplCopyWith<_$SwitchTabEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetScanStateEventImplCopyWith<$Res> {
  factory _$$ResetScanStateEventImplCopyWith(
    _$ResetScanStateEventImpl value,
    $Res Function(_$ResetScanStateEventImpl) then,
  ) = __$$ResetScanStateEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetScanStateEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$ResetScanStateEventImpl>
    implements _$$ResetScanStateEventImplCopyWith<$Res> {
  __$$ResetScanStateEventImplCopyWithImpl(
    _$ResetScanStateEventImpl _value,
    $Res Function(_$ResetScanStateEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetScanStateEventImpl implements ResetScanStateEvent {
  const _$ResetScanStateEventImpl();

  @override
  String toString() {
    return 'OutboundCollectEvent.resetScanState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetScanStateEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return resetScanState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return resetScanState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (resetScanState != null) {
      return resetScanState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return resetScanState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return resetScanState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (resetScanState != null) {
      return resetScanState(this);
    }
    return orElse();
  }
}

abstract class ResetScanStateEvent implements OutboundCollectEvent {
  const factory ResetScanStateEvent() = _$ResetScanStateEventImpl;
}

/// @nodoc
abstract class _$$SetScanStepEventImplCopyWith<$Res> {
  factory _$$SetScanStepEventImplCopyWith(
    _$SetScanStepEventImpl value,
    $Res Function(_$SetScanStepEventImpl) then,
  ) = __$$SetScanStepEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ScanStep step});
}

/// @nodoc
class __$$SetScanStepEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$SetScanStepEventImpl>
    implements _$$SetScanStepEventImplCopyWith<$Res> {
  __$$SetScanStepEventImplCopyWithImpl(
    _$SetScanStepEventImpl _value,
    $Res Function(_$SetScanStepEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? step = null}) {
    return _then(
      _$SetScanStepEventImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as ScanStep,
      ),
    );
  }
}

/// @nodoc

class _$SetScanStepEventImpl implements SetScanStepEvent {
  const _$SetScanStepEventImpl({required this.step});

  @override
  final ScanStep step;

  @override
  String toString() {
    return 'OutboundCollectEvent.setScanStep(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetScanStepEventImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetScanStepEventImplCopyWith<_$SetScanStepEventImpl> get copyWith =>
      __$$SetScanStepEventImplCopyWithImpl<_$SetScanStepEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return setScanStep(step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return setScanStep?.call(step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setScanStep != null) {
      return setScanStep(step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return setScanStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return setScanStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setScanStep != null) {
      return setScanStep(this);
    }
    return orElse();
  }
}

abstract class SetScanStepEvent implements OutboundCollectEvent {
  const factory SetScanStepEvent({required final ScanStep step}) =
      _$SetScanStepEventImpl;

  ScanStep get step;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetScanStepEventImplCopyWith<_$SetScanStepEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCurrentSiteEventImplCopyWith<$Res> {
  factory _$$SetCurrentSiteEventImplCopyWith(
    _$SetCurrentSiteEventImpl value,
    $Res Function(_$SetCurrentSiteEventImpl) then,
  ) = __$$SetCurrentSiteEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String siteCode});
}

/// @nodoc
class __$$SetCurrentSiteEventImplCopyWithImpl<$Res>
    extends _$OutboundCollectEventCopyWithImpl<$Res, _$SetCurrentSiteEventImpl>
    implements _$$SetCurrentSiteEventImplCopyWith<$Res> {
  __$$SetCurrentSiteEventImplCopyWithImpl(
    _$SetCurrentSiteEventImpl _value,
    $Res Function(_$SetCurrentSiteEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? siteCode = null}) {
    return _then(
      _$SetCurrentSiteEventImpl(
        siteCode: null == siteCode
            ? _value.siteCode
            : siteCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SetCurrentSiteEventImpl implements SetCurrentSiteEvent {
  const _$SetCurrentSiteEventImpl({required this.siteCode});

  @override
  final String siteCode;

  @override
  String toString() {
    return 'OutboundCollectEvent.setCurrentSite(siteCode: $siteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentSiteEventImpl &&
            (identical(other.siteCode, siteCode) ||
                other.siteCode == siteCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, siteCode);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentSiteEventImplCopyWith<_$SetCurrentSiteEventImpl> get copyWith =>
      __$$SetCurrentSiteEventImplCopyWithImpl<_$SetCurrentSiteEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return setCurrentSite(siteCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return setCurrentSite?.call(siteCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setCurrentSite != null) {
      return setCurrentSite(siteCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return setCurrentSite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return setCurrentSite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setCurrentSite != null) {
      return setCurrentSite(this);
    }
    return orElse();
  }
}

abstract class SetCurrentSiteEvent implements OutboundCollectEvent {
  const factory SetCurrentSiteEvent({required final String siteCode}) =
      _$SetCurrentSiteEventImpl;

  String get siteCode;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentSiteEventImplCopyWith<_$SetCurrentSiteEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCurrentMaterialEventImplCopyWith<$Res> {
  factory _$$SetCurrentMaterialEventImplCopyWith(
    _$SetCurrentMaterialEventImpl value,
    $Res Function(_$SetCurrentMaterialEventImpl) then,
  ) = __$$SetCurrentMaterialEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BarcodeContent barcodeContent});

  $BarcodeContentCopyWith<$Res> get barcodeContent;
}

/// @nodoc
class __$$SetCurrentMaterialEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$SetCurrentMaterialEventImpl>
    implements _$$SetCurrentMaterialEventImplCopyWith<$Res> {
  __$$SetCurrentMaterialEventImplCopyWithImpl(
    _$SetCurrentMaterialEventImpl _value,
    $Res Function(_$SetCurrentMaterialEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? barcodeContent = null}) {
    return _then(
      _$SetCurrentMaterialEventImpl(
        barcodeContent: null == barcodeContent
            ? _value.barcodeContent
            : barcodeContent // ignore: cast_nullable_to_non_nullable
                  as BarcodeContent,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BarcodeContentCopyWith<$Res> get barcodeContent {
    return $BarcodeContentCopyWith<$Res>(_value.barcodeContent, (value) {
      return _then(_value.copyWith(barcodeContent: value));
    });
  }
}

/// @nodoc

class _$SetCurrentMaterialEventImpl implements SetCurrentMaterialEvent {
  const _$SetCurrentMaterialEventImpl({required this.barcodeContent});

  @override
  final BarcodeContent barcodeContent;

  @override
  String toString() {
    return 'OutboundCollectEvent.setCurrentMaterial(barcodeContent: $barcodeContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentMaterialEventImpl &&
            (identical(other.barcodeContent, barcodeContent) ||
                other.barcodeContent == barcodeContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, barcodeContent);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentMaterialEventImplCopyWith<_$SetCurrentMaterialEventImpl>
  get copyWith =>
      __$$SetCurrentMaterialEventImplCopyWithImpl<
        _$SetCurrentMaterialEventImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return setCurrentMaterial(barcodeContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return setCurrentMaterial?.call(barcodeContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setCurrentMaterial != null) {
      return setCurrentMaterial(barcodeContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return setCurrentMaterial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return setCurrentMaterial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (setCurrentMaterial != null) {
      return setCurrentMaterial(this);
    }
    return orElse();
  }
}

abstract class SetCurrentMaterialEvent implements OutboundCollectEvent {
  const factory SetCurrentMaterialEvent({
    required final BarcodeContent barcodeContent,
  }) = _$SetCurrentMaterialEventImpl;

  BarcodeContent get barcodeContent;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentMaterialEventImplCopyWith<_$SetCurrentMaterialEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExceptionCollectEventImplCopyWith<$Res> {
  factory _$$ExceptionCollectEventImplCopyWith(
    _$ExceptionCollectEventImpl value,
    $Res Function(_$ExceptionCollectEventImpl) then,
  ) = __$$ExceptionCollectEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CollectRecord record, String reason});

  $CollectRecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$ExceptionCollectEventImplCopyWithImpl<$Res>
    extends
        _$OutboundCollectEventCopyWithImpl<$Res, _$ExceptionCollectEventImpl>
    implements _$$ExceptionCollectEventImplCopyWith<$Res> {
  __$$ExceptionCollectEventImplCopyWithImpl(
    _$ExceptionCollectEventImpl _value,
    $Res Function(_$ExceptionCollectEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? record = null, Object? reason = null}) {
    return _then(
      _$ExceptionCollectEventImpl(
        record: null == record
            ? _value.record
            : record // ignore: cast_nullable_to_non_nullable
                  as CollectRecord,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectRecordCopyWith<$Res> get record {
    return $CollectRecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value));
    });
  }
}

/// @nodoc

class _$ExceptionCollectEventImpl implements ExceptionCollectEvent {
  const _$ExceptionCollectEventImpl({
    required this.record,
    required this.reason,
  });

  @override
  final CollectRecord record;
  @override
  final String reason;

  @override
  String toString() {
    return 'OutboundCollectEvent.exceptionCollect(record: $record, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExceptionCollectEventImpl &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, record, reason);

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExceptionCollectEventImplCopyWith<_$ExceptionCollectEventImpl>
  get copyWith =>
      __$$ExceptionCollectEventImplCopyWithImpl<_$ExceptionCollectEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      OutboundTask task,
      String userId,
      String workStation,
    )
    initialize,
    required TResult Function() loadTaskItems,
    required TResult Function() refreshTaskItems,
    required TResult Function(String searchKey) searchTaskItems,
    required TResult Function(String content) processScanCode,
    required TResult Function(String siteCode) validateSite,
    required TResult Function(BarcodeContent barcodeContent, String siteCode)
    validateMaterial,
    required TResult Function(InventoryQuery query) queryInventory,
    required TResult Function(int quantity) confirmQuantity,
    required TResult Function(CollectRecord record) addCollectRecord,
    required TResult Function(int index) removeCollectRecord,
    required TResult Function() clearCollectRecords,
    required TResult Function() submitCollectData,
    required TResult Function(String outTaskItemId) reportShortage,
    required TResult Function(int tabIndex) switchTab,
    required TResult Function() resetScanState,
    required TResult Function(ScanStep step) setScanStep,
    required TResult Function(String siteCode) setCurrentSite,
    required TResult Function(BarcodeContent barcodeContent) setCurrentMaterial,
    required TResult Function(CollectRecord record, String reason)
    exceptionCollect,
  }) {
    return exceptionCollect(record, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult? Function()? loadTaskItems,
    TResult? Function()? refreshTaskItems,
    TResult? Function(String searchKey)? searchTaskItems,
    TResult? Function(String content)? processScanCode,
    TResult? Function(String siteCode)? validateSite,
    TResult? Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult? Function(InventoryQuery query)? queryInventory,
    TResult? Function(int quantity)? confirmQuantity,
    TResult? Function(CollectRecord record)? addCollectRecord,
    TResult? Function(int index)? removeCollectRecord,
    TResult? Function()? clearCollectRecords,
    TResult? Function()? submitCollectData,
    TResult? Function(String outTaskItemId)? reportShortage,
    TResult? Function(int tabIndex)? switchTab,
    TResult? Function()? resetScanState,
    TResult? Function(ScanStep step)? setScanStep,
    TResult? Function(String siteCode)? setCurrentSite,
    TResult? Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult? Function(CollectRecord record, String reason)? exceptionCollect,
  }) {
    return exceptionCollect?.call(record, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTask task, String userId, String workStation)?
    initialize,
    TResult Function()? loadTaskItems,
    TResult Function()? refreshTaskItems,
    TResult Function(String searchKey)? searchTaskItems,
    TResult Function(String content)? processScanCode,
    TResult Function(String siteCode)? validateSite,
    TResult Function(BarcodeContent barcodeContent, String siteCode)?
    validateMaterial,
    TResult Function(InventoryQuery query)? queryInventory,
    TResult Function(int quantity)? confirmQuantity,
    TResult Function(CollectRecord record)? addCollectRecord,
    TResult Function(int index)? removeCollectRecord,
    TResult Function()? clearCollectRecords,
    TResult Function()? submitCollectData,
    TResult Function(String outTaskItemId)? reportShortage,
    TResult Function(int tabIndex)? switchTab,
    TResult Function()? resetScanState,
    TResult Function(ScanStep step)? setScanStep,
    TResult Function(String siteCode)? setCurrentSite,
    TResult Function(BarcodeContent barcodeContent)? setCurrentMaterial,
    TResult Function(CollectRecord record, String reason)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (exceptionCollect != null) {
      return exceptionCollect(record, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitializeCollectEvent value) initialize,
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(RefreshTaskItemsEvent value) refreshTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ProcessScanCodeEvent value) processScanCode,
    required TResult Function(ValidateSiteEvent value) validateSite,
    required TResult Function(ValidateMaterialEvent value) validateMaterial,
    required TResult Function(QueryInventoryEvent value) queryInventory,
    required TResult Function(ConfirmQuantityEvent value) confirmQuantity,
    required TResult Function(AddCollectRecordEvent value) addCollectRecord,
    required TResult Function(RemoveCollectRecordEvent value)
    removeCollectRecord,
    required TResult Function(ClearCollectRecordsEvent value)
    clearCollectRecords,
    required TResult Function(SubmitCollectDataEvent value) submitCollectData,
    required TResult Function(ReportShortageEvent value) reportShortage,
    required TResult Function(SwitchTabEvent value) switchTab,
    required TResult Function(ResetScanStateEvent value) resetScanState,
    required TResult Function(SetScanStepEvent value) setScanStep,
    required TResult Function(SetCurrentSiteEvent value) setCurrentSite,
    required TResult Function(SetCurrentMaterialEvent value) setCurrentMaterial,
    required TResult Function(ExceptionCollectEvent value) exceptionCollect,
  }) {
    return exceptionCollect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitializeCollectEvent value)? initialize,
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ProcessScanCodeEvent value)? processScanCode,
    TResult? Function(ValidateSiteEvent value)? validateSite,
    TResult? Function(ValidateMaterialEvent value)? validateMaterial,
    TResult? Function(QueryInventoryEvent value)? queryInventory,
    TResult? Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult? Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult? Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult? Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult? Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult? Function(ReportShortageEvent value)? reportShortage,
    TResult? Function(SwitchTabEvent value)? switchTab,
    TResult? Function(ResetScanStateEvent value)? resetScanState,
    TResult? Function(SetScanStepEvent value)? setScanStep,
    TResult? Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult? Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult? Function(ExceptionCollectEvent value)? exceptionCollect,
  }) {
    return exceptionCollect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitializeCollectEvent value)? initialize,
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(RefreshTaskItemsEvent value)? refreshTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ProcessScanCodeEvent value)? processScanCode,
    TResult Function(ValidateSiteEvent value)? validateSite,
    TResult Function(ValidateMaterialEvent value)? validateMaterial,
    TResult Function(QueryInventoryEvent value)? queryInventory,
    TResult Function(ConfirmQuantityEvent value)? confirmQuantity,
    TResult Function(AddCollectRecordEvent value)? addCollectRecord,
    TResult Function(RemoveCollectRecordEvent value)? removeCollectRecord,
    TResult Function(ClearCollectRecordsEvent value)? clearCollectRecords,
    TResult Function(SubmitCollectDataEvent value)? submitCollectData,
    TResult Function(ReportShortageEvent value)? reportShortage,
    TResult Function(SwitchTabEvent value)? switchTab,
    TResult Function(ResetScanStateEvent value)? resetScanState,
    TResult Function(SetScanStepEvent value)? setScanStep,
    TResult Function(SetCurrentSiteEvent value)? setCurrentSite,
    TResult Function(SetCurrentMaterialEvent value)? setCurrentMaterial,
    TResult Function(ExceptionCollectEvent value)? exceptionCollect,
    required TResult orElse(),
  }) {
    if (exceptionCollect != null) {
      return exceptionCollect(this);
    }
    return orElse();
  }
}

abstract class ExceptionCollectEvent implements OutboundCollectEvent {
  const factory ExceptionCollectEvent({
    required final CollectRecord record,
    required final String reason,
  }) = _$ExceptionCollectEventImpl;

  CollectRecord get record;
  String get reason;

  /// Create a copy of OutboundCollectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExceptionCollectEventImplCopyWith<_$ExceptionCollectEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}
