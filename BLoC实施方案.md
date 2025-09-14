# 出库采集页面BLoC实施方案

## 文档说明
本文档详细记录了出库采集页面重构的BLoC架构设计方案，用于下次会话时继续讨论和实施。

## 当前架构分析

### 1. OutboundCollectBloc现状

**文件位置**: `/Users/ming/Documents/金风项目/wms_app/lib/modules/outbound/collection_task/bloc/outbound_collect_bloc.dart`

**复杂状态管理**:
- 管理任务、任务明细、采集记录、扫码状态等多个状态
- 业务逻辑复杂：包含扫码验证、库存查询、采集记录管理、数据提交等
- 依赖服务层：依赖 `OutboundTaskService` 进行数据操作
- 状态类型丰富：包含loading、loaded、error、scanProcessing、submitting等多种状态

**核心功能**:
- 初始化采集页面
- 加载任务明细列表
- 处理扫码流程（库位验证、物料验证、库存查询）
- 管理采集记录的CRUD操作
- 处理数据提交和异常操作
- Tab切换和状态重置

### 2. CommonDataGridBloc特点

**文件位置**: `/Users/ming/Documents/金风项目/wms_app/lib/common_widgets/common_grid/grid_bloc.dart`

**专注表格数据**:
- 只管理表格的数据加载、分页、选择等基本功能
- 通用性强：通过泛型支持不同类型的数据
- 简单架构：只有dataLoader和dataDeleter两个核心功能
- 状态简单：只管理表格相关状态（数据、分页、选择、错误信息）

**核心功能**:
- 数据加载和分页
- 行选择管理
- 数据删除
- 表格数据更新

## BLoC整合方案

### 方案选择：双BLoC协作模式

#### 架构设计
```
OutboundCollectPage
├── CommonDataGridBloc<OutboundTaskItem> (表格数据管理)
├── OutboundCollectBloc (业务逻辑管理)
└── 页面UI
```

#### 职责分工

**1. CommonDataGridBloc职责**
- 管理任务明细列表的表格显示
- 处理表格的分页加载
- 管理行选择状态
- 提供表格刷新功能

**2. OutboundCollectBloc职责**
- 管理扫码流程（库位验证、物料验证、库存查询）
- 管理采集记录的CRUD操作
- 处理数据提交和异常操作
- 管理当前采集状态和扫码步骤

#### 数据流设计

**1. 初始化流程**
```
页面初始化 → OutboundCollectBloc初始化 → 加载任务明细 → 更新CommonDataGridBloc
```

**2. 数据同步机制**
```dart
// OutboundCollectBloc中
final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);

// 更新CommonDataGridBloc
_gridBloc.add(UpdateTableDataEvent(response.rows));
```

**3. 事件协调**
- **表格刷新**：采集完成后触发表格数据更新
- **状态同步**：采集状态变化时同步更新UI显示

## 具体实现代码

### 1. 创建表格BLoC

```dart
// 在OutboundCollectPage中
late final CommonDataGridBloc<OutboundTaskItem> _gridBloc = 
    CommonDataGridBloc<OutboundTaskItem>(
      dataLoader: (pageIndex) async {
        // 从OutboundCollectBloc获取数据
        final query = CollectTaskQuery(
          outTaskNo: _currentTask.outTaskNo,
          collecter: _currentUserId,
          pageIndex: pageIndex,
        );
        final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);
        return DataGridResponseData(
          totalPages: (response.total / query.pageSize).ceil(),
          data: response.rows,
        );
      },
    );
```

### 2. 简化OutboundCollectBloc

**移除的功能**:
- 任务明细列表的管理逻辑
- 搜索和筛选功能（如果表格已支持）

**保留的功能**:
- 扫码流程管理
- 采集记录管理
- 数据提交和异常操作
- 状态管理

### 3. 数据同步实现

```dart
// 在OutboundCollectBloc中添加表格刷新方法
void refreshTaskItems() {
  _gridBloc.add(LoadDataEvent(0));
}

// 在采集完成后调用
Future<void> _onSubmitCollectData(...) async {
  // 提交逻辑...
  _gridBloc.add(LoadDataEvent(0)); // 刷新表格
}
```

### 4. 跨BLoC通信

```dart
// 在页面中使用BlocListener监听状态变化
BlocListener<OutboundCollectBloc, OutboundCollectState>(
  listener: (context, state) {
    if (state is OutboundCollectSubmitted) {
      _gridBloc.add(LoadDataEvent(0)); // 刷新表格
    }
  },
)
```

### 5. 事件处理优化

```dart
// 统一事件入口
void handleTableEvent(dynamic event) {
  if (event is TableSelectionEvent) {
    // 处理表格选择
  } else if (event is ScanEvent) {
    // 处理扫码事件，交给OutboundCollectBloc
    _collectBloc.add(event);
  }
}
```

## 状态管理优化

### 1. 状态分离

**表格数据状态**: 由CommonDataGridBloc管理
- 表格数据列表
- 当前页码
- 总页数
- 选中行
- 加载状态

**业务逻辑状态**: 由OutboundCollectBloc管理
- 当前采集任务
- 采集记录列表
- 扫码步骤状态
- 当前库位和物料信息
- 提交状态

**UI状态**: 由页面组件管理
- Tab切换状态
- 搜索关键字
- 对话框显示状态

### 2. 避免状态冲突

**原则**:
- 每个状态只由一个BLoC管理
- 避免状态循环依赖
- 明确数据流向

**实现**:
```dart
// 使用Provider或其他方式避免循环依赖
class OutboundCollectPage extends StatefulWidget {
  @override
  State<OutboundCollectPage> createState() => _OutboundCollectPageState();
}

class _OutboundCollectPageState extends State<OutboundCollectPage> {
  late final OutboundCollectBloc _collectBloc;
  late final CommonDataGridBloc<OutboundTaskItem> _gridBloc;
  
  @override
  void initState() {
    super.initState();
    _collectBloc = context.read<OutboundCollectBloc>();
    _gridBloc = CommonDataGridBloc<OutboundTaskItem>(
      dataLoader: _createDataLoader(),
    );
  }
  
  DataLoader<OutboundTaskItem> _createDataLoader() {
    return (pageIndex) async {
      // 通过collectBloc获取数据
      final currentState = _collectBloc.state;
      if (currentState is OutboundCollectLoaded) {
        final query = CollectTaskQuery(
          outTaskNo: currentState.task.outTaskNo,
          collecter: currentState.userId,
          pageIndex: pageIndex,
        );
        final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);
        return DataGridResponseData(
          totalPages: (response.total / query.pageSize).ceil(),
          data: response.rows,
        );
      }
      return DataGridResponseData(totalPages: 0, data: []);
    };
  }
}
```

## 性能优化策略

### 1. 避免重复加载

```dart
// 使用缓存机制
class _OutboundCollectPageState extends State<OutboundCollectPage> {
  final Map<int, List<OutboundTaskItem>> _cache = {};
  
  DataLoader<OutboundTaskItem> _createDataLoader() {
    return (pageIndex) async {
      if (_cache.containsKey(pageIndex)) {
        return DataGridResponseData(
          totalPages: _calculateTotalPages(),
          data: _cache[pageIndex]!,
        );
      }
      
      // 加载数据并缓存
      final data = await _loadDataFromService(pageIndex);
      _cache[pageIndex] = data;
      
      return DataGridResponseData(
        totalPages: _calculateTotalPages(),
        data: data,
      );
    };
  }
}
```

### 2. 合理使用Completer

```dart
// 在OutboundCollectBloc中使用Completer进行异步协调
Future<void> _onLoadTaskItems(
  LoadTaskItemsEvent event,
  Emitter<OutboundCollectState> emit,
) async {
  final completer = Completer<void>();
  
  try {
    final query = CollectTaskQuery(
      outTaskNo: currentState.task.outTaskNo,
      collecter: currentState.userId,
    );
    
    final response = await _outboundTaskService.getOutTaskCollectItemList(
      query: query,
    );
    
    emit(currentState.copyWith(taskItems: response.rows));
    completer.complete();
    
    // 通知表格刷新
    _gridBloc.add(LoadDataEvent(0));
  } catch (e) {
    emit(currentState.copyWith(errorMessage: '加载任务明细失败: $e'));
    completer.completeError(e);
  }
}
```

### 3. 内存管理

```dart
@override
void dispose() {
  // 清理资源
  _gridBloc.close();
  _cache.clear();
  super.dispose();
}
```

## 下次讨论要点

### 1. 技术实现细节
- 双BLoC协作模式的具体实现
- 状态同步机制的设计
- 性能优化策略的实施

### 2. 架构设计问题
- 如何处理复杂的业务逻辑分离
- 如何避免状态循环依赖
- 如何确保数据一致性

### 3. 具体实现问题
- 表格配置的列定义
- 顶部操作菜单的交互设计
- 异常采集和报缺功能的实现

### 4. 测试和验收
- 单元测试策略
- 集成测试方法
- 性能测试标准

## 相关文件位置

### 当前文件
- OutboundCollectBloc: `/Users/ming/Documents/金风项目/wms_app/lib/modules/outbound/collection_task/bloc/outbound_collect_bloc.dart`
- CommonDataGridBloc: `/Users/ming/Documents/金风项目/wms_app/lib/common_widgets/common_grid/grid_bloc.dart`
- OutboundCollectPage: `/Users/ming/Documents/金风项目/wms_app/lib/modules/outbound/collection_task/outbound_collect_page.dart`

### 参考文件
- OutboundTaskBloc: `/Users/ming/Documents/金风项目/wms_app/lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart`
- OutboundTaskListPage: `/Users/ming/Documents/金风项目/wms_app/lib/modules/outbound/task_list/outbound_task_list_page.dart`

## 开始对话的方式

下次您可以通过以下方式开始对话：

```
请查看我之前保存的BLoC实施方案文档：/Users/ming/Documents/金风项目/wms_app/BLoC实施方案.md

我想继续讨论[具体议题]，比如：
- 开始实施第一阶段：BLoC重构
- 讨论状态同步机制的设计
- 分析具体的技术实现细节
- 或者基于现有方案进行调整
```

这样可以确保我能够快速理解项目背景，继续为您提供技术支持。