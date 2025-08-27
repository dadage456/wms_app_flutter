import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/outbound_task_bloc.dart';
import 'services/outbound_task_service.dart';
import 'pages/outbound_task_list_page.dart';
import '../../services/user_manager.dart';

/// 出库模块
class OutboundModule extends Module {
  @override
  void binds(Injector i) {
    // 注册服务
    i.addSingleton<OutboundTaskService>(
      () => OutboundTaskService(i.get<Dio>()),
    );

    // 注册BLoC
    i.add<OutboundTaskBloc>(
      () => OutboundTaskBloc(
        outboundTaskService: i.get<OutboundTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    // 出库任务列表页面
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<OutboundTaskBloc>(),
        child: const OutboundTaskListPage(),
      ),
    );

    // 出库任务列表页面（显式路由）
    r.child(
      '/list',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<OutboundTaskBloc>(),
        child: const OutboundTaskListPage(),
      ),
    );
  }
}
