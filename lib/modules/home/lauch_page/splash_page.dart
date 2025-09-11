import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/services/api_service.dart';
import 'package:wms_app/services/user_manager.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用Future.delayed模拟启动页加载时间
    useEffect(() {
      // 延迟2秒后根据登录状态跳转页面
      Future.delayed(const Duration(seconds: 2), () {});

      _checkLoginStatus(context);

      return null;
    }, []);

    return Scaffold(
      body: Container(
        color: Color(0xFF0067FC),
        child: Center(
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
      ),
    );
  }

  /// 检查登录状态
  Future<void> _checkLoginStatus(BuildContext context) async {
    try {
      final userManager = Modular.get<UserManager>();
      final apiService = Modular.get<ApiService>();

      // 等待用户信息加载完成
      await userManager.loadUserLoginInfo();

      if (context.mounted) {
        // 检查是否已登录
        if (userManager.isLogin) {
          try {
            final loginInfo = userManager.userLoginInfo!;
            await apiService.login(loginInfo.username, loginInfo.password);
            // 已登录，跳转到主页面
            Modular.to.pushReplacementNamed('/home');
          } catch (e) {
            Modular.to.pushReplacementNamed('/login');
          }
        } else {
          // 未登录，跳转到登录页面
          Modular.to.pushReplacementNamed('/login');
        }
      }
    } catch (e) {
      // 处理异常，例如网络错误等
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('启动失败: $e')));
      }
    }
  }
}
