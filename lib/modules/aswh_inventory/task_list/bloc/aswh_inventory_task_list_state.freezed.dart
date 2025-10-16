// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aswh_inventory_task_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AswhInventoryTaskListState {
  AswhTaskListStatus get status => throw _privateConstructorUsedError;
  InventoryTaskFilter get filter => throw _privateConstructorUsedError;
  List<InventoryTaskSummary> get tasks => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AswhInventoryTaskListStateCopyWith<AswhInventoryTaskListState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhInventoryTaskListStateCopyWith<$Res> {
  factory $AswhInventoryTaskListStateCopyWith(AswhInventoryTaskListState value,
          $Res Function(AswhInventoryTaskListState) then) =
      _$AswhInventoryTaskListStateCopyWithImpl<$Res,
          AswhInventoryTaskListState>;
  @useResult
  $Res call(
      {AswhTaskListStatus status,
      InventoryTaskFilter filter,
      List<InventoryTaskSummary> tasks,
      int total,
      int currentPage,
      int totalPages,
      String? message});

  $InventoryTaskFilterCopyWith<$Res> get filter;
}

/// @nodoc
class _$AswhInventoryTaskListStateCopyWithImpl<$Res,
        $Val extends AswhInventoryTaskListState>
    implements $AswhInventoryTaskListStateCopyWith<$Res> {
  _$AswhInventoryTaskListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? filter = null,
    Object? tasks = null,
    Object? total = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AswhTaskListStatus,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as InventoryTaskFilter,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskSummary>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryTaskFilterCopyWith<$Res> get filter {
    return $InventoryTaskFilterCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AswhInventoryTaskListStateImplCopyWith<$Res>
    implements $AswhInventoryTaskListStateCopyWith<$Res> {
  factory _$$AswhInventoryTaskListStateImplCopyWith(
          _$AswhInventoryTaskListStateImpl value,
          $Res Function(_$AswhInventoryTaskListStateImpl) then) =
      __$$AswhInventoryTaskListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AswhTaskListStatus status,
      InventoryTaskFilter filter,
      List<InventoryTaskSummary> tasks,
      int total,
      int currentPage,
      int totalPages,
      String? message});

  @override
  $InventoryTaskFilterCopyWith<$Res> get filter;
}

/// @nodoc
class __$$AswhInventoryTaskListStateImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListStateCopyWithImpl<$Res,
        _$AswhInventoryTaskListStateImpl>
    implements _$$AswhInventoryTaskListStateImplCopyWith<$Res> {
  __$$AswhInventoryTaskListStateImplCopyWithImpl(
      _$AswhInventoryTaskListStateImpl _value,
      $Res Function(_$AswhInventoryTaskListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? filter = null,
    Object? tasks = null,
    Object? total = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? message = freezed,
  }) {
    return _then(_$AswhInventoryTaskListStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AswhTaskListStatus,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as InventoryTaskFilter,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskSummary>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AswhInventoryTaskListStateImpl implements _AswhInventoryTaskListState {
  const _$AswhInventoryTaskListStateImpl(
      {this.status = AswhTaskListStatus.initial,
      required this.filter,
      final List<InventoryTaskSummary> tasks = const <InventoryTaskSummary>[],
      this.total = 0,
      this.currentPage = 1,
      this.totalPages = 1,
      this.message})
      : _tasks = tasks;

  @override
  @JsonKey()
  final AswhTaskListStatus status;
  @override
  final InventoryTaskFilter filter;
  final List<InventoryTaskSummary> _tasks;
  @override
  @JsonKey()
  List<InventoryTaskSummary> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  final String? message;

  @override
  String toString() {
    return 'AswhInventoryTaskListState(status: $status, filter: $filter, tasks: $tasks, total: $total, currentPage: $currentPage, totalPages: $totalPages, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhInventoryTaskListStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      filter,
      const DeepCollectionEquality().hash(_tasks),
      total,
      currentPage,
      totalPages,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhInventoryTaskListStateImplCopyWith<_$AswhInventoryTaskListStateImpl>
      get copyWith => __$$AswhInventoryTaskListStateImplCopyWithImpl<
          _$AswhInventoryTaskListStateImpl>(this, _$identity);
}

abstract class _AswhInventoryTaskListState
    implements AswhInventoryTaskListState {
  const factory _AswhInventoryTaskListState(
      {final AswhTaskListStatus status,
      required final InventoryTaskFilter filter,
      final List<InventoryTaskSummary> tasks,
      final int total,
      final int currentPage,
      final int totalPages,
      final String? message}) = _$AswhInventoryTaskListStateImpl;

  @override
  AswhTaskListStatus get status;
  @override
  InventoryTaskFilter get filter;
  @override
  List<InventoryTaskSummary> get tasks;
  @override
  int get total;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AswhInventoryTaskListStateImplCopyWith<_$AswhInventoryTaskListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
