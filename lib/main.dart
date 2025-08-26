import 'package:flutter/material.dart';
import 'package:wms_app/common/user_manager.dart';
import 'package:wms_app/pages/home/home_paeg.dart';
import '/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '金风WMS应用',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const UserLoginPage(),
      },
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 应用图标
            const Icon(Icons.inventory_2, size: 100, color: Colors.white),
            const SizedBox(height: 24),
            // 应用名称
            const Text(
              '金风WMS',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // 副标题
            const Text(
              '仓库管理系统',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 48),
            // 加载指示器
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
