# CLAUDE.md

此文件为Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

这是金风科技的WMS（仓库管理系统）Flutter应用程序，用于替代传统的C# Windows CE PDA应用程序。系统专注于仓库操作，特别是带有条码扫描和库存管理的出库采集任务。

### 核心组件
- **Flutter应用程序**（主要）- 替代传统C#应用的现代化版本
- **传统参考** - 原始C# .NET Framework 2.0 Compact Framework Windows CE应用程序
- **UniApp组件** - 基于Vue的登录模板

## 开发命令

### 基础Flutter命令
```bash
# 安装依赖
flutter pub get

# 在连接的设备/模拟器上运行
flutter run

# 代码质量分析
flutter analyze

# 运行测试（如果可用）
flutter test

# 生产构建
flutter build apk --release
flutter build ios --release
```

### 代码生成命令
```bash
# 生成JSON序列化、Freezed模型和Hive适配器
flutter pub run build_runner build

# 监听变更并自动重新生成
flutter pub run build_runner watch

# 清理并重新生成所有代码
flutter pub run build_runner build --delete-conflicting-outputs
```

### 原生启动画面
```bash
# 生成启动画面
flutter pub run flutter_native_splash:create
```

## 架构概述

### 模块化架构
- **Flutter Modular**: 依赖注入和路由管理
- **模块结构**: `/lib/modules/` 包含功能模块
- **服务注册**: 核心服务在`AppModule`中注册

### 状态管理模式
- **BLoC模式**: 使用`flutter_bloc`的主要状态管理
- **多BLoC协调**: 复杂页面使用多个BLoC（参见`BLoC实施方案.md`）
- **通用BLoC**: `CommonDataGridBloc<T>`用于可重用的表格逻辑

### 核心架构层
```
├── 表示层 (UI)
│   ├── 页面 (功能界面)
│   ├── 组件 (可重用组件)
│   └── BLoCs (状态管理)
├── 服务层
│   ├── API服务 (HTTP通信)
│   ├── 本地存储 (Hive数据库)
│   └── 业务逻辑服务
└── 数据层
    ├── 模型 (Freezed生成)
    ├── 适配器 (Hive类型适配器)
    └── API客户端 (Dio包装器)
```

## 关键技术组件

### 状态管理
- **OutboundCollectBloc**: 复杂的采集任务管理，包含扫码工作流
- **CommonDataGridBloc<T>**: 通用表格数据管理，支持分页
- **LoginBloc**: 认证和用户会话管理
- **跨BLoC通信**: 多个BLoC之间的事件协调

### 数据持久化
- **Hive数据库**: 用于离线功能的本地存储
- **自定义适配器**: 复杂模型的类型适配器（`OutTaskItemAdapter`、`BarcodeContentAdapter`、`CollectionStockAdapter`）
- **共享首选项**: 应用设置的简单键值存储

### API集成
- **DioClient**: 带有拦截器和错误处理的HTTP客户端
- **ApiService**: 带有认证的核心API服务
- **特定功能服务**: `OutboundTaskService`、`UserService`等

### UI组件
- **Syncfusion DataGrid**: 高级表格组件，支持排序、过滤、分页
- **自定义组件**: 扫码器集成、通用表单、数据网格
- **Material Design**: Google字体、自定义主题、响应式布局

## 业务逻辑上下文

### 三步扫码工作流
1. **库位扫描** - 条码格式包含`$KW$`标识符
2. **物料二维码扫描** - 格式包含`MC`标识符
3. **数量输入** - 数字格式验证

### 物料控制类型
- **序列号控制** (Serial Number Control)
- **批次控制** (Batch Control) - 强管控/弱管控
- **库存验证** (Inventory Validation)
- **ERP子库一致性校验** (ERP Subinventory Validation)

### 核心业务实体
- **OutTaskItem**: 出库任务行项目
- **BarcodeContent**: 解析的条码信息
- **CollectionStock**: 采集库存记录
- **CollectTaskQuery**: 带分页的任务查询参数

## 模块结构

### 主页模块 (`/lib/modules/home/`)
- 登录和认证
- 启动画面和应用初始化
- 主导航

### 出库模块 (`/lib/modules/outbound/`)
- **任务列表**: 浏览和筛选出库任务
- **采集任务**: 三步扫码采集界面
- **异常处理**: 报告短缺和采集问题

### 通用组件 (`/lib/common_widgets/`)
- **数据网格系统**: 带BLoC集成的通用表格
- **扫码器组件**: 基于摄像头的条码扫描
- **表单组件**: 可重用的输入字段和验证

### 服务 (`/lib/services/`)
- **API层**: 与后端的HTTP通信
- **用户管理**: 会话和认证
- **Dio客户端**: HTTP客户端配置

## 开发工作流

### 代码生成工作流
1. 使用`@freezed`和`@jsonSerializable`修改模型类
2. 运行`flutter pub run build_runner build`生成：
   - `.g.dart`文件（JSON序列化）
   - `.freezed.dart`文件（不可变模型）
   - 本地存储的Hive适配器

### BLoC开发模式
1. 在`*_event.dart`中定义事件
2. 在`*_state.dart`中定义状态
3. 在`*_bloc.dart`中实现业务逻辑
4. 在UI组件中使用`BlocProvider`和`BlocBuilder`
5. 对于复杂页面，协调多个BLoC（参考文档）

### 测试策略
- BLoC和服务的单元测试
- 完整工作流的集成测试
- UI组件的组件测试

## 重要文件

### 核心配置
- `pubspec.yaml` - 依赖和项目配置
- `analysis_options.yaml` - Dart分析规则
- `app_module.dart` - 依赖注入和路由设置

### 关键文档
- `BLoC实施方案.md` - 详细的BLoC架构和实施计划
- `business_rules.md` - 业务逻辑规则和验证要求
- `出库采集页面重构方案.md` - UI重构规范

### 传统参考
- 中文文档文件包含详细的业务需求
- 原始C#应用程序逻辑作为Flutter实现的参考

## API配置

### 开发环境
API端点在`DioClient`和服务类中配置。检查各个服务文件以获取特定的端点配置。

### 认证
通过`UserManager`进行用户会话管理，在`ApiService`中处理基于令牌的认证。