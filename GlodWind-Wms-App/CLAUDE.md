# CLAUDE.md

此文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

这是一个基于 **UniApp 的 WMS（仓库管理系统）移动应用程序**，使用 Vue.js 和 FirstUI 组件构建。该应用程序提供全面的仓库管理功能，包括库存采集、收发货、盘点和异常处理。

## 核心架构

### 技术栈
- **框架**: UniApp (Vue.js 2)
- **UI 组件**: FirstUI + GraceUI5
- **状态管理**: Vuex
- **构建目标**: 多平台（iOS 应用、Android 应用、微信小程序、H5）
- **原生渲染**: 使用 `.nvue` 文件在移动设备上实现原生性能

### 项目结构
```
/
├── pages/                   # 所有应用页面（混合 .vue/.nvue 文件）
│   ├── account/            # 登录/注册页面
│   ├── goodsdown/          # 平库出库
│   ├── goodsup/            # 平库入库
│   ├── aswhdown/           # 在线拣选
│   ├── aswhup/             # 立库组盘
│   ├── arrive_sign/        # 到货签收
│   ├── Inventorytask/      # 平库盘点
│   ├── aswhInventorytask/  # 立库盘点
│   ├── transfer/           # 平库移库
│   ├── queryrepertory/     # 库存查询
│   ├── mtlsenter/          # 拉式发料
│   ├── exceptColl/         # 异常采集
│   └── msg/                # 消息中心
├── components/
│   ├── firstui/            # FirstUI 组件库
│   └── scan-code/          # 条码扫描组件
├── common/                 # 通用工具和样式
├── store/                  # Vuex 状态管理
├── api/                    # API 服务模块
├── static/                 # 静态资源（图片、字体）
├── utils/                  # 工具函数
├── App.vue                 # 主应用组件
├── main.js                 # 应用入口点
├── manifest.json           # 应用配置和权限
├── pages.json              # 页面路由和配置
└── config.js               # 应用配置（API 基础 URL 等）
```

## 开发命令

### 环境设置和依赖安装
```bash
# 安装依赖
npm install
# 或
yarn install
# 或
pnpm install
```

### 开发
```bash
# 在 HBuilderX 中开发（推荐）
# 在 HBuilderX IDE 中打开项目

# 在浏览器中运行（功能有限）
npm run dev:h5

# 构建不同平台
npm run build:app-plus      # 移动应用
npm run build:h5           # 网页版
npm run build:mp-weixin    # 微信小程序
```

### 构建和发布
```bash
# 构建移动应用（需要 HBuilderX）
# 使用 HBuilderX 发布到应用商店

# 构建微信小程序
npm run build:mp-weixin

# 构建支付宝小程序
npm run build:mp-alipay
```

## 核心业务逻辑

### 主要仓库操作
1. **到货签收**: `pages/arrive_sign/`
   - 任务接收和确认
   - 采集和明细管理

2. **平库出库**: `pages/goodsdown/`
   - 任务接收、详细采集
   - 三步扫描流程：库位 → 物料二维码 → 数量

3. **平库入库**: `pages/goodsup/`
   - 货物接收和上架

4. **在线拣选**: `pages/aswhdown/`
   - 自动化仓库拣选操作

5. **库存盘点**: `pages/Inventorytask/` 和 `pages/aswhInventorytask/`
   - 平库和自动化仓库库存盘点

### 通用功能
- **条码扫描**: 与 PDA 设备集成的扫描功能
- **任务管理**: 统一的任务接收、处理和完成流程
- **异常处理**: 全面的异常采集和管理
- **实时消息**: 推送通知和消息中心
- **数据同步**: 与后端 WMS 系统实时同步

## 关键配置

### API 配置
- **基础 URL**: 在 `config.js` 中配置（当前：`http://10.12.8.123:8086`）
- **环境**: 多个环境 URL 已注释，便于切换

### 权限配置 (manifest.json)
- **相机**: 条码扫描必需
- **存储**: 数据缓存必需
- **网络**: API 通信必需
- **推送通知**: 任务通知必需

### 页面配置
- **原生渲染**: 大多数页面使用 `.nvue` 扩展名以获得原生性能
- **自定义导航**: 使用 `navigationStyle: "custom"` 实现一致的 UI
- **平台优化**: 针对不同目标的平台特定配置

## 开发注意事项

### 组件使用
- **FirstUI**: 主要 UI 组件库，具有一致的主题
- **GraceUI5**: 额外的组件和工具
- **自定义组件**: 条码扫描器和其他业务特定组件

### 状态管理
- **Vuex Store**: 用户会话和应用状态的集中管理
- **本地存储**: 用于缓存和离线功能

### API 集成
- **模块化 API 服务**: 在 `api/` 目录中按业务域组织
- **错误处理**: 全面的错误处理和用户友好的消息
- **请求拦截器**: 身份验证和错误处理中间件

### 条码扫描
- **PDA 集成**: 为工业 PDA 设备优化
- **多格式支持**: 支持各种条码和二维码格式
- **实时处理**: 即时验证和反馈

### 性能优化
- **原生渲染**: 使用 `.nvue` 获得更好的移动性能
- **延迟加载**: 按需加载页面
- **内存管理**: 定期缓存清除和内存优化