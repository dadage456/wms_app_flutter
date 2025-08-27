import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/pages/login/bloc/login_bloc.dart';
import 'package:wms_app/pages/login/bloc/login_event.dart';
import 'package:wms_app/pages/login/bloc/login_state.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<LoginBloc>(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 hooks 管理状态
    final usernameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final obscurePassword = useState(true);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset('assets/images/login_top_circle.svg'),
          ),
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
            child: SafeArea(
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
          ),
        ],
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
            ),
            const SizedBox(height: 26),
            // Password field
            _buildPasswordField(
              controller: passwordController,
              obscurePassword: obscurePassword,
            ),
            const SizedBox(height: 52),
            // Login button
            _buildLoginButton(() {}),
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
              style: const TextStyle(
                color: Color(0xFF222B3C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// 登录按钮组件
  Widget _buildLoginButton(void Function() onPressed) {
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
}
