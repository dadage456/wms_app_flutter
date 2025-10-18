// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_query_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryQueryState _$InventoryQueryStateFromJson(Map<String, dynamic> json) {
  return _InventoryQueryState.fromJson(json);
}

/// @nodoc
mixin _$InventoryQueryState {
  PageStatus get status => throw _privateConstructorUsedError;
  InventoryBarcodeMaterial? get barcodeMaterial =>
      throw _privateConstructorUsedError;
  InventorySummary get summary => throw _privateConstructorUsedError;
  List<InventoryRecord> get records => throw _privateConstructorUsedError;
  InventoryQueryMode get selectedMode => throw _privateConstructorUsedError;
  String? get queryValue => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get focusTick => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryQueryStateCopyWith<InventoryQueryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryQueryStateCopyWith<$Res> {
  factory $InventoryQueryStateCopyWith(
          InventoryQueryState value, $Res Function(InventoryQueryState) then) =
      _$InventoryQueryStateCopyWithImpl<$Res, InventoryQueryState>;
  @useResult
  $Res call(
      {PageStatus status,
      InventoryBarcodeMaterial? barcodeMaterial,
      InventorySummary summary,
      List<InventoryRecord> records,
      InventoryQueryMode selectedMode,
      String? queryValue,
      int currentPage,
      int pageSize,
      int total,
      String? errorMessage,
      int focusTick});

  $InventoryBarcodeMaterialCopyWith<$Res>? get barcodeMaterial;
  $InventorySummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$InventoryQueryStateCopyWithImpl<$Res, $Val extends InventoryQueryState>
    implements $InventoryQueryStateCopyWith<$Res> {
  _$InventoryQueryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? barcodeMaterial = freezed,
    Object? summary = null,
    Object? records = null,
    Object? selectedMode = null,
    Object? queryValue = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? total = null,
    Object? errorMessage = freezed,
    Object? focusTick = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      barcodeMaterial: freezed == barcodeMaterial
          ? _value.barcodeMaterial
          : barcodeMaterial // ignore: cast_nullable_to_non_nullable
              as InventoryBarcodeMaterial?,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as InventorySummary,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<InventoryRecord>,
      selectedMode: null == selectedMode
          ? _value.selectedMode
          : selectedMode // ignore: cast_nullable_to_non_nullable
              as InventoryQueryMode,
      queryValue: freezed == queryValue
          ? _value.queryValue
          : queryValue // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      focusTick: null == focusTick
          ? _value.focusTick
          : focusTick // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryBarcodeMaterialCopyWith<$Res>? get barcodeMaterial {
    if (_value.barcodeMaterial == null) {
      return null;
    }

    return $InventoryBarcodeMaterialCopyWith<$Res>(_value.barcodeMaterial!,
        (value) {
      return _then(_value.copyWith(barcodeMaterial: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InventorySummaryCopyWith<$Res> get summary {
    return $InventorySummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InventoryQueryStateImplCopyWith<$Res>
    implements $InventoryQueryStateCopyWith<$Res> {
  factory _$$InventoryQueryStateImplCopyWith(_$InventoryQueryStateImpl value,
          $Res Function(_$InventoryQueryStateImpl) then) =
      __$$InventoryQueryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus status,
      InventoryBarcodeMaterial? barcodeMaterial,
      InventorySummary summary,
      List<InventoryRecord> records,
      InventoryQueryMode selectedMode,
      String? queryValue,
      int currentPage,
      int pageSize,
      int total,
      String? errorMessage,
      int focusTick});

  @override
  $InventoryBarcodeMaterialCopyWith<$Res>? get barcodeMaterial;
  @override
  $InventorySummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$InventoryQueryStateImplCopyWithImpl<$Res>
    extends _$InventoryQueryStateCopyWithImpl<$Res, _$InventoryQueryStateImpl>
    implements _$$InventoryQueryStateImplCopyWith<$Res> {
  __$$InventoryQueryStateImplCopyWithImpl(_$InventoryQueryStateImpl _value,
      $Res Function(_$InventoryQueryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? barcodeMaterial = freezed,
    Object? summary = null,
    Object? records = null,
    Object? selectedMode = null,
    Object? queryValue = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? total = null,
    Object? errorMessage = freezed,
    Object? focusTick = null,
  }) {
    return _then(_$InventoryQueryStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      barcodeMaterial: freezed == barcodeMaterial
          ? _value.barcodeMaterial
          : barcodeMaterial // ignore: cast_nullable_to_non_nullable
              as InventoryBarcodeMaterial?,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as InventorySummary,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<InventoryRecord>,
      selectedMode: null == selectedMode
          ? _value.selectedMode
          : selectedMode // ignore: cast_nullable_to_non_nullable
              as InventoryQueryMode,
      queryValue: freezed == queryValue
          ? _value.queryValue
          : queryValue // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      focusTick: null == focusTick
          ? _value.focusTick
          : focusTick // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryQueryStateImpl extends _InventoryQueryState {
  const _$InventoryQueryStateImpl(
      {this.status = PageStatus.initial,
      this.barcodeMaterial,
      this.summary = const InventorySummary(),
      final List<InventoryRecord> records = const <InventoryRecord>[],
      this.selectedMode = InventoryQueryMode.material,
      this.queryValue,
      this.currentPage = 1,
      this.pageSize = 10000,
      this.total = 0,
      this.errorMessage,
      this.focusTick = 0})
      : _records = records,
        super._();

  factory _$InventoryQueryStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryQueryStateImplFromJson(json);

  @override
  @JsonKey()
  final PageStatus status;
  @override
  final InventoryBarcodeMaterial? barcodeMaterial;
  @override
  @JsonKey()
  final InventorySummary summary;
  final List<InventoryRecord> _records;
  @override
  @JsonKey()
  List<InventoryRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  @JsonKey()
  final InventoryQueryMode selectedMode;
  @override
  final String? queryValue;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int total;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final int focusTick;

  @override
  String toString() {
    return 'InventoryQueryState(status: $status, barcodeMaterial: $barcodeMaterial, summary: $summary, records: $records, selectedMode: $selectedMode, queryValue: $queryValue, currentPage: $currentPage, pageSize: $pageSize, total: $total, errorMessage: $errorMessage, focusTick: $focusTick)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryQueryStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.barcodeMaterial, barcodeMaterial) ||
                other.barcodeMaterial == barcodeMaterial) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.selectedMode, selectedMode) ||
                other.selectedMode == selectedMode) &&
            (identical(other.queryValue, queryValue) ||
                other.queryValue == queryValue) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.focusTick, focusTick) ||
                other.focusTick == focusTick));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      barcodeMaterial,
      summary,
      const DeepCollectionEquality().hash(_records),
      selectedMode,
      queryValue,
      currentPage,
      pageSize,
      total,
      errorMessage,
      focusTick);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryQueryStateImplCopyWith<_$InventoryQueryStateImpl> get copyWith =>
      __$$InventoryQueryStateImplCopyWithImpl<_$InventoryQueryStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryQueryStateImplToJson(
      this,
    );
  }
}

abstract class _InventoryQueryState extends InventoryQueryState {
  const factory _InventoryQueryState(
      {final PageStatus status,
      final InventoryBarcodeMaterial? barcodeMaterial,
      final InventorySummary summary,
      final List<InventoryRecord> records,
      final InventoryQueryMode selectedMode,
      final String? queryValue,
      final int currentPage,
      final int pageSize,
      final int total,
      final String? errorMessage,
      final int focusTick}) = _$InventoryQueryStateImpl;
  const _InventoryQueryState._() : super._();

  factory _InventoryQueryState.fromJson(Map<String, dynamic> json) =
      _$InventoryQueryStateImpl.fromJson;

  @override
  PageStatus get status;
  @override
  InventoryBarcodeMaterial? get barcodeMaterial;
  @override
  InventorySummary get summary;
  @override
  List<InventoryRecord> get records;
  @override
  InventoryQueryMode get selectedMode;
  @override
  String? get queryValue;
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  int get total;
  @override
  String? get errorMessage;
  @override
  int get focusTick;
  @override
  @JsonKey(ignore: true)
  _$$InventoryQueryStateImplCopyWith<_$InventoryQueryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
