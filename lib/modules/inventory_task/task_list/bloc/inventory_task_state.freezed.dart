// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InventoryTaskState {
  InventoryTaskListStatus get status => throw _privateConstructorUsedError;
  InventoryTaskQuery get filter => throw _privateConstructorUsedError;
  List<InventoryTask> get tasks => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InventoryTaskStateCopyWith<InventoryTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskStateCopyWith<$Res> {
  factory $InventoryTaskStateCopyWith(
          InventoryTaskState value, $Res Function(InventoryTaskState) then) =
      _$InventoryTaskStateCopyWithImpl<$Res, InventoryTaskState>;
  @useResult
  $Res call(
      {InventoryTaskListStatus status,
      InventoryTaskQuery filter,
      List<InventoryTask> tasks,
      int currentPage,
      int totalPages,
      int total,
      String? message});

  $InventoryTaskQueryCopyWith<$Res> get filter;
}

/// @nodoc
class _$InventoryTaskStateCopyWithImpl<$Res, $Val extends InventoryTaskState>
    implements $InventoryTaskStateCopyWith<$Res> {
  _$InventoryTaskStateCopyWithImpl(this._value, this._then);

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
    Object? currentPage = null,
    Object? totalPages = null,
    Object? total = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InventoryTaskListStatus,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as InventoryTaskQuery,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<InventoryTask>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryTaskQueryCopyWith<$Res> get filter {
    return $InventoryTaskQueryCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InventoryTaskStateImplCopyWith<$Res>
    implements $InventoryTaskStateCopyWith<$Res> {
  factory _$$InventoryTaskStateImplCopyWith(_$InventoryTaskStateImpl value,
          $Res Function(_$InventoryTaskStateImpl) then) =
      __$$InventoryTaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InventoryTaskListStatus status,
      InventoryTaskQuery filter,
      List<InventoryTask> tasks,
      int currentPage,
      int totalPages,
      int total,
      String? message});

  @override
  $InventoryTaskQueryCopyWith<$Res> get filter;
}

/// @nodoc
class __$$InventoryTaskStateImplCopyWithImpl<$Res>
    extends _$InventoryTaskStateCopyWithImpl<$Res, _$InventoryTaskStateImpl>
    implements _$$InventoryTaskStateImplCopyWith<$Res> {
  __$$InventoryTaskStateImplCopyWithImpl(_$InventoryTaskStateImpl _value,
      $Res Function(_$InventoryTaskStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? filter = null,
    Object? tasks = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? total = null,
    Object? message = freezed,
  }) {
    return _then(_$InventoryTaskStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InventoryTaskListStatus,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as InventoryTaskQuery,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<InventoryTask>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InventoryTaskStateImpl implements _InventoryTaskState {
  const _$InventoryTaskStateImpl(
      {this.status = InventoryTaskListStatus.initial,
      this.filter = const InventoryTaskQuery(userId: '', roleOrUserId: ''),
      final List<InventoryTask> tasks = const <InventoryTask>[],
      this.currentPage = 1,
      this.totalPages = 1,
      this.total = 0,
      this.message})
      : _tasks = tasks;

  @override
  @JsonKey()
  final InventoryTaskListStatus status;
  @override
  @JsonKey()
  final InventoryTaskQuery filter;
  final List<InventoryTask> _tasks;
  @override
  @JsonKey()
  List<InventoryTask> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int total;
  @override
  final String? message;

  @override
  String toString() {
    return 'InventoryTaskState(status: $status, filter: $filter, tasks: $tasks, currentPage: $currentPage, totalPages: $totalPages, total: $total, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      filter,
      const DeepCollectionEquality().hash(_tasks),
      currentPage,
      totalPages,
      total,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskStateImplCopyWith<_$InventoryTaskStateImpl> get copyWith =>
      __$$InventoryTaskStateImplCopyWithImpl<_$InventoryTaskStateImpl>(
          this, _$identity);
}

abstract class _InventoryTaskState implements InventoryTaskState {
  const factory _InventoryTaskState(
      {final InventoryTaskListStatus status,
      final InventoryTaskQuery filter,
      final List<InventoryTask> tasks,
      final int currentPage,
      final int totalPages,
      final int total,
      final String? message}) = _$InventoryTaskStateImpl;

  @override
  InventoryTaskListStatus get status;
  @override
  InventoryTaskQuery get filter;
  @override
  List<InventoryTask> get tasks;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get total;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskStateImplCopyWith<_$InventoryTaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
