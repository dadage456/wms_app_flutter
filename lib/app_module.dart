import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/modules/home/lauch_page/splash_page.dart';
import 'package:wms_app/modules/home/login/bloc/login_bloc.dart';
import 'package:wms_app/services/dio_client.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/modules/home/home_page.dart';
import 'package:wms_app/modules/home/login/login_page.dart';
import 'package:wms_app/services/api_service.dart';
import 'modules/outbound/outbound_module.dart';
import 'modules/goods_up/goods_up_module.dart';

/// 应用主模块
class AppModule extends Module {
  @override
  void binds(Injector i) {
    // 注册核心服务
    i.addSingleton<DioClient>(() => DioClient());
    i.addSingleton<ApiService>(
      () => ApiService(i.get<DioClient>(), i.get<UserManager>()),
    );
    i.addSingleton<UserManager>(() => UserManager());

    i.add<LoginBloc>(
      () => LoginBloc(
        apiService: i.get<ApiService>(),
        userManager: i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    // 启动页面
    r.child('/', child: (context) => const SplashScreen());

    // 登录页面
    r.child('/login', child: (context) => const UserLoginPage());

    // 主页面
    r.child('/home', child: (context) => const WMSHomePage());

    // 出库模块
    r.module('/outbound', module: OutboundModule());

    // 平库上架模块
    r.module('/goods-up', module: GoodsUpModule());
  }
}
