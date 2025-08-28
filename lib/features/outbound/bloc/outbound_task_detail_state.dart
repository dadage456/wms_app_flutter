import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/outbound_task_item.dart';

part 'outbound_task_detail_state.freezed.dart';

/// 出库任务明细状态
@freezed
class OutboundTaskDetailState with _$OutboundTaskDetailState {
  /// 初始状态
  const factory OutboundTaskDetailState.initial() = _Initial;

  /// 加载中状态
  const factory OutboundTaskDetailState.loading() = _Loading;

  /// 加载成功状态
  const factory OutboundTaskDetailState.loaded({
    required List<OutboundTaskItem> taskItems,
    required Set<String> selectedItemIds,
    required bool hasMore,
    required int currentPage,
    required int totalCount,
    OutboundTaskItemQuery? currentQuery,
    MaterialInfo? scannedMaterial,
  }) = _Loaded;

  /// 加载失败状态
  const factory OutboundTaskDetailState.error({
    required String message,
    List<OutboundTaskItem>? taskItems,
    Set<String>? selectedItemIds,
  }) = _Error;

  /// 扫码中状态
  const factory OutboundTaskDetailState.scanning() = _Scanning;

  /// 撤销中状态
  const factory OutboundTaskDetailState.cancelling({
    required List<OutboundTaskItem> taskItems,
    required Set<String> selectedItemIds,
  }) = _Cancelling;
}

/// 状态扩展方法
extension OutboundTaskDetailStateX on OutboundTaskDetailState {
  /// 获取任务明细列表
  List<OutboundTaskItem> get taskItems => when(
    initial: () => [],
    loading: () => [],
    loaded: (items, _, __, ___, ____, _____, ______) => items,
    error: (_, items, __) => items ?? [],
    scanning: () => [],
    cancelling: (items, _) => items,
  );

  /// 获取选中的项目ID集合
  Set<String> get selectedItemIds => when(
    initial: () => <String>{},
    loading: () => <String>{},
    loaded: (_, selected, __, ___, ____, _____, ______) => selected,
    error: (_, __, selected) => selected ?? <String>{},
    scanning: () => <String>{},
    cancelling: (_, selected) => selected,
  );

  /// 是否正在加载
  bool get isLoading => when(
    initial: () => false,
    loading: () => true,
    loaded: (_, __, ___, ____, _____, ______, _______) => false,
    error: (_, __, ___) => false,
    scanning: () => true,
    cancelling: (_, __) => true,
  );

  /// 是否有错误
  bool get hasError => when(
    initial: () => false,
    loading: () => false,
    loaded: (_, __, ___, ____, _____, ______, _______) => false,
    error: (_, __, ___) => true,
    scanning: () => false,
    cancelling: (_, __) => false,
  );

  /// 获取错误信息
  String? get errorMessage => when(
    initial: () => null,
    loading: () => null,
    loaded: (_, __, ___, ____, _____, ______, _______) => null,
    error: (message, _, __) => message,
    scanning: () => null,
    cancelling: (_, __) => null,
  );

  /// 是否有更多数据
  bool get hasMore => when(
    initial: () => true,
    loading: () => true,
    loaded: (_, __, hasMore, ___, ____, _____, ______) => hasMore,
    error: (_, __, ___) => false,
    scanning: () => false,
    cancelling: (_, __) => false,
  );

  /// 获取当前页码
  int get currentPage => when(
    initial: () => 1,
    loading: () => 1,
    loaded: (_, __, ___, page, ____, _____, ______) => page,
    error: (_, __, ___) => 1,
    scanning: () => 1,
    cancelling: (_, __) => 1,
  );

  /// 获取总数量
  int get totalCount => when(
    initial: () => 0,
    loading: () => 0,
    loaded: (_, __, ___, ____, total, _____, ______) => total,
    error: (_, __, ___) => 0,
    scanning: () => 0,
    cancelling: (_, __) => 0,
  );

  /// 获取当前查询参数
  OutboundTaskItemQuery? get currentQuery => when(
    initial: () => null,
    loading: () => null,
    loaded: (_, __, ___, ____, _____, query, ______) => query,
    error: (_, __, ___) => null,
    scanning: () => null,
    cancelling: (_, __) => null,
  );

  /// 获取扫描的物料信息
  MaterialInfo? get scannedMaterial => when(
    initial: () => null,
    loading: () => null,
    loaded: (_, __, ___, ____, _____, ______, material) => material,
    error: (_, __, ___) => null,
    scanning: () => null,
    cancelling: (_, __) => null,
  );

  /// 是否全选
  bool get isAllSelected {
    final items = taskItems;
    final selected = selectedItemIds;
    return items.isNotEmpty && items.length == selected.length;
  }

  /// 是否有选中项
  bool get hasSelectedItems => selectedItemIds.isNotEmpty;

  /// 选中项数量
  int get selectedCount => selectedItemIds.length;
}
