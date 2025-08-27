import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wms_app/services/user_manager.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用Future.delayed模拟启动页加载时间
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        final user = Modular.get<UserManager>();
        if (user.isLogin) {
          Modular.to.pushReplacementNamed('/home');
        } else {
          Modular.to.pushReplacementNamed('/login');
        }
      });
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
}
