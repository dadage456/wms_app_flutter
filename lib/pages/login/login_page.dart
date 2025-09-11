import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/pages/login/bloc/login_bloc.dart';
import 'package:wms_app/pages/login/bloc/login_event.dart';
import 'package:wms_app/pages/login/bloc/login_state.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/common_widgets/keyboard_dismiss_ontap.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: BlocProvider(
        create: (context) => Modular.get<LoginBloc>(),
        child: const LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 hooks 管理状态
    final userManager = Modular.get<UserManager>();
    final userName = userManager.userLoginInfo?.username ?? '';
    final usernameController = useTextEditingController(text: userName);
    final passwordController = useTextEditingController(text: '');
    final obscurePassword = useState(true);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // 登录成功，跳转到主页面
          context.hideLoadingDialog();
          _showSuccessMessage(context, '登录成功');
          // 延迟跳转，让用户看到成功提示
          Future.delayed(const Duration(milliseconds: 800), () {
            Modular.to.pushReplacementNamed('/home');
          });
        } else if (state is LoginFailure) {
          // 登录失败，显示错误信息
          context.hideLoadingDialog();
          _showErrorMessage(context, state.error);
        } else if (state is LoginLoading) {
          // 显示加载对话框
          context.showLoadingDialog(message: '正在登录...');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0067FC), Color(0xFF0067FC)],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset('assets/images/login_top_circle.svg'),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Header section with title
                  _buildHeadSection(),
                  // Form container - 使用 Expanded 填充剩余空间
                  Expanded(
                    child: _buildFormSection(
                      usernameController: usernameController,
                      passwordController: passwordController,
                      obscurePassword: obscurePassword,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 头部组件
  Widget _buildHeadSection() {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Navigation title
          const Text(
            '登录',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 100),
          // Main title
          const Text(
            '金风科技WMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 26),
          // Subtitle
          const Text(
            '欢迎登录金风科技WMS仓储管理系统',
            style: TextStyle(
              color: Color(0xCCFFFFFF), // 80% opacity white
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }

  /// 表单区域组件
  Widget _buildFormSection({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required ValueNotifier<bool> obscurePassword,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            // Username field
            _buildInputField(
              controller: usernameController,
              icon: Icons.person_outline,
              iconColor: const Color(0xFF222B3C),
              hintText: '请输入用户名',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 26),
            // Password field
            _buildPasswordField(
              controller: passwordController,
              obscurePassword: obscurePassword,
            ),
            const SizedBox(height: 52),
            // Login button
            Builder(
              builder: (context) {
                return _buildLoginButton(
                  onPressed: () => _handleLogin(
                    context,
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  ),
                );
              },
            ),
            // 添加底部间距，确保键盘弹出时有足够空间
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 通用输入框组件
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required Color iconColor,
    bool obscureText = false,
    Widget? suffixIcon,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          // Icon
          SizedBox(
            width: 20,
            height: 20,
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 8),
          // Text field
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                color: Color(0xFF222B3C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Suffix icon
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }

  /// 密码输入框组件
  Widget _buildPasswordField({
    required TextEditingController controller,
    required ValueNotifier<bool> obscurePassword,
  }) {
    return _buildInputField(
      controller: controller,
      icon: Icons.lock_outline,
      iconColor: const Color(0xFF272636),
      obscureText: obscurePassword.value,
      hintText: '请输入密码',
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () {
          obscurePassword.value = !obscurePassword.value;
        },
        child: SizedBox(
          width: 20,
          height: 20,
          child: Icon(
            obscurePassword.value ? Icons.visibility_off : Icons.visibility,
            size: 20,
            color: const Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  /// 登录按钮组件
  Widget _buildLoginButton({required void Function() onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0067FC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          elevation: 0,
        ),
        child: const Text(
          '登录',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 处理登录逻辑
  void _handleLogin(BuildContext context, String username, String password) {
    // 表单验证
    final validationResult = _validateLoginForm(username, password);
    if (validationResult != null) {
      _showErrorMessage(context, validationResult);
      return;
    }

    // 发送登录事件
    BlocProvider.of<LoginBloc>(
      context,
    ).add(LoginButtonTap(username: username, password: password));
  }

  /// 表单验证
  String? _validateLoginForm(String username, String password) {
    if (username.isEmpty && password.isEmpty) {
      return '请输入用户名和密码';
    }
    if (username.isEmpty) {
      return '请输入用户名';
    }
    if (password.isEmpty) {
      return '请输入密码';
    }
    if (username.length < 2) {
      return '用户名至少需要2个字符';
    }
    if (password.length < 6) {
      return '密码至少需要6个字符';
    }
    return null;
  }

  /// 显示错误消息
  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 显示成功消息
  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
