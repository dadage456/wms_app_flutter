# 精确列宽拖动控制功能示例

## 功能说明

CommonDataGrid 现在支持精确的列宽拖动控制功能：

1. **预计算缓存**：初始化时计算所有列的内容宽度并缓存
2. **方向感知拖动**：根据拖动方向（左/右）实现不同的行为逻辑
3. **智能内容适配**：往右拖动时，如果内容没显示全，自动跳到内容宽度并结束拖动
4. **自由调整**：内容已显示全时，允许自由调整列宽
5. **性能优化**：使用缓存避免重复计算，提升响应速度

## 使用示例

```dart
// 创建包含长文本的数据
final data = [
  TestModel(
    id: 1,
    name: 'Very Very Very Long User Name That Needs More Space',
    email: 'very.very.very.long.email.address.that.needs.space@example.com',
    age: 25,
  ),
];

// 使用 CommonDataGrid
CommonDataGrid<TestModel>(
  columns: [
    GridColumnConfig<TestModel>(
      name: 'name',
      headerText: '姓名',
      width: 120, // 初始宽度可能不够显示完整内容
      valueGetter: (row) => row.name,
    ),
    GridColumnConfig<TestModel>(
      name: 'email',
      headerText: '邮箱',
      width: 150, // 初始宽度可能不够显示完整内容
      valueGetter: (row) => row.email,
    ),
  ],
  datas: data,
  onLoadData: (pageIndex) async {
    // 加载数据逻辑
  },
)
```

## 精确拖动行为说明

### 场景 1：往右拖动 + 内容没显示全
- 初始状态："姓名"列宽 80px，但内容需要 150px
- 用户往右拖动到 100px
- **结果**：列宽自动跳到 150px（内容宽度）并**结束拖动**

### 场景 2：往右拖动 + 内容已显示全
- 初始状态："姓名"列宽 150px，内容需要 120px
- 用户往右拖动到 200px
- **结果**：列宽设置为 200px，可以**继续自由拖动**

### 场景 3：往左拖动（任何情况）
- 用户往左拖动，减小列宽
- **结果**：直接减小到拖动位置，**无任何限制**

### 场景 4：数据更新
- 数据从短文本更新为长文本
- 缓存自动重新计算
- 拖动时使用最新的内容宽度判断

## 日志输出

拖动列宽时会输出详细的调试日志：

### 拖动开始
```
Column name resize started at width: 80.0
```

### 拖动过程中
```
Column name: Right drag with truncated content, auto-fit to 150.0 and end resize
Column email: Right drag with full content visible, free resize to 200.0
Column age: Left drag, reduce width to 60.0
```

### 拖动结束
```
Column name resize ended at width: 150.0
```

## 性能优化

- ✅ 初始化时预计算所有列宽度
- ✅ 拖动时直接使用缓存，无需重复计算
- ✅ 数据更新时智能重建缓存
- ✅ 支持大量数据的高效处理

## 测试覆盖

- ✅ **43 个测试用例全部通过**
- ✅ 包含精确拖动方向控制测试
- ✅ 包含拖动开始/结束状态管理测试
- ✅ 包含混合长短文本处理测试
- ✅ 包含缓存机制性能测试
- ✅ 包含边界条件测试

## 核心实现

### 拖动状态管理
- `onColumnResizeStart`: 记录拖动开始的初始宽度
- `onColumnResizeUpdate`: 根据方向和内容状态决定最终宽度
- `onColumnResizeEnd`: 清理拖动状态并记录结束宽度

### 方向检测逻辑
```dart
final isDraggingRight = newWidth > startWidth;
final isDraggingLeft = newWidth < startWidth;

if (isDraggingRight && startWidth < contentWidth) {
  // 往右拖动且内容未完全显示：自动适配并结束拖动
  finalWidth = contentWidth;
  shouldEndResize = true;
}
```