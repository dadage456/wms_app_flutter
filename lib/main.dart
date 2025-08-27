import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/pages/home/home_page.dart';
import '/pages/login/login_page.dart';
import 'app_module.dart';

void main() {
  // 加载用户信息
  UserManager().loadUserInfo();

  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '金风WMS应用',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}

/// 启动页面 - 检查用户登录状态
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  /// 检查用户登录状态
  Future<void> _checkLoginStatus() async {
    try {
      // 等待用户信息加载完成
      await UserManager().loadUserInfo();

      // 延迟一下，让用户看到启动画面
      await Future.delayed(const Duration(milliseconds: 1500));

      if (mounted) {
        // 检查是否已登录
        if (UserManager().isLoggedIn) {
          // 已登录，跳转到主页面
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          // 未登录，跳转到登录页面
          Navigator.of(context).pushReplacementNamed('/login');
        }
      }
    } catch (e) {
      // 如果出现错误，默认跳转到登录页面
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: Column()),
    );
  }
}
