import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/app_module.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_bloc.dart';
import 'package:wms_app/modules/outbound/collection_task/outbound_collection_page.dart';
import 'package:wms_app/modules/outbound/collection_task/services/collection_service.dart';

import 'task_list/bloc/outbound_task_bloc.dart';
import 'task_details/bloc/outbound_task_detail_bloc.dart';
import 'services/outbound_task_service.dart';
import 'task_list/outbound_task_list_page.dart';
import 'task_details/outbound_task_detail_page.dart';
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

    i.addSingleton<CollectionService>(
      () => CollectionService(i.get<DioClient>().dio),
    );

    // 注册BLoC
    i.add<OutboundTaskBloc>(
      () => OutboundTaskBloc(
        outboundTaskService: i.get<OutboundTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    // 注册出库任务明细BLoC
    i.add<OutboundTaskDetailBloc>(
      () => OutboundTaskDetailBloc(
        i.get<OutboundTaskService>(),
        i.get<UserManager>(),
      ),
    );

    // 注册出库采集BLoC
    i.add<CollectionBloc>(() => CollectionBloc(i.get<CollectionService>()));
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

    // 出库任务明细页面
    r.child(
      '/detail/:outTaskId',
      child: (context) {
        final args = Modular.args;
        final outTaskId = args.params['outTaskId'] ?? '';
        final workStation = args.data['workStation'] ?? '';
        final int userId = args.data['userId'];
        final int roleOrUserId = args.data['roleOrUserId'];

        log(
          'Navigating to detail page: $outTaskId $workStation $userId $roleOrUserId',
        );

        return BlocProvider(
          create: (context) => Modular.get<OutboundTaskDetailBloc>(),
          child: OutboundTaskDetailPage(
            outTaskId: outTaskId,
            workStation: workStation,
            userId: userId,
            roleOrUserId: roleOrUserId,
          ),
        );
      },
    );

    // 出库采集页面
    r.child(
      '/collect/:outTaskNo',
      child: (context) {
        final args = Modular.args;

        log(
          'Navigating to collect page: ${args.data}',
        );

        return BlocProvider(
          create: (context) => Modular.get<CollectionBloc>(),
          child: OutboundCollectionPage(task: args.data['task'],),
        );
      },
    );
  }
}
