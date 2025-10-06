# 账号与设置模块重构 TODO

## UniApp 现状
- 登录相关：`pages/account/login/login.nvue`、`loginPwd/loginPwd.nvue`、`reg/reg.nvue`
- 设置相关：`pages/set/resetPwd.nvue`、`setPwd.nvue`
- 通用组件：`pages/common/captcha/captcha.nvue`、`pages/common/area/area.nvue`
- 提供账号登录、密码登录/重置、注册、验证码、地区选择等功能。

## Flutter 现状与目标
- Flutter 已实现基础登录页面（`lib/modules/home/login/login_page.dart`）与 `LoginBloc`，需扩展以覆盖密码登录、验证码验证、注册、密码重置等能力。【F:lib/modules/home/login/login_page.dart†L1-L200】
- 目标：统一账号体系，提供完整的登录方式切换、密码重置、注册流程，与后端接口对齐。

## Flutter 重构策略
- **模块结构**：扩展 `home` 模块或新建 `auth_module`，包含以下子页面：
  - 账号登录（用户名/验证码切换）
  - 密码登录/修改
  - 注册页面
  - 验证码输入组件
  - 地区选择组件
- **状态管理**：
  - 登录与注册沿用现有 `LoginBloc`，扩展事件/状态处理验证码、注册、密码重置流程。
  - 设置/密码修改可使用独立 `AccountSettingCubit` 管理表单状态与 API 调用。
- **UI 指南**：
  - 沿用现有登录页面的视觉风格、`LoadingDialogManager` 与 `KeyboardDismissOnTap` 机制，保持一致体验。【F:lib/modules/home/login/login_page.dart†L31-L193】
  - 可将验证码输入、地区选择实现为 `BottomSheet` 或弹窗组件，复用 `CustomAppBar` 规范。
- **服务层**：
  - 扩展 `UserService`/`LoginService`，封装登录、注册、验证码、密码修改 API 调用，参考 `OutboundTaskService` 的组织方式。【F:lib/modules/outbound/services/outbound_task_service.dart†L1-L104】

## 待办清单
1. 梳理后台账号接口（登录、注册、验证码、密码重置），补充 `UserService` 封装。
2. 扩展 `LoginBloc`：
   - 新增事件：验证码登录、请求验证码、注册、重置密码。
   - 新增状态：验证码发送成功/失败、注册成功、重置成功。
3. 登录页面：
   - 添加登录方式切换（账号密码/验证码），支持账号记忆。
   - 整合验证码输入与倒计时组件。
4. 注册页面：
   - 复用表单组件，提供账号、手机号、验证码、密码输入；提交后跳转登录。
5. 密码设置页面：
   - `setPwd` 与 `resetPwd`：实现旧密码校验、设置新密码流程。
6. 通用组件：
   - 验证码弹窗/页面、地区选择列表组件，支持搜索、选择结果回传。
7. 路由整合：
   - `/auth/login`、`/auth/register`、`/auth/reset-password`、`/auth/set-password` 等路由，在 `AppModule` 中注册。
8. 测试：
   - BLoC 测试覆盖登录成功/失败、验证码倒计时、注册、密码修改流程。
   - Service Mock 验证接口参数、异常处理。
9. 文档：
   - 更新账号体系说明、登录方式、密码策略、验证码流程。
