import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/app_module.dart';
import 'package:wms_app/features/outbound/bloc/outbound_task_state.dart';

import 'bloc/outbound_task_bloc.dart';
import 'services/outbound_task_service.dart';
import 'pages/outbound_task_list_page.dart';
import '../../services/user_manager.dart';
import '../../services/dio_client.dart';

/// 出库模块
class OutboundModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    // 注册服务
    i.addSingleton<OutboundTaskService>(
      () => OutboundTaskService(i.get<DioClient>().dio),
    );

    // 注册BLoC
    i.addLazySingleton<OutboundTaskBloc>(
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
