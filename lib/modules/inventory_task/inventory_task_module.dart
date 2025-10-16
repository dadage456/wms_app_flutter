import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import '../../services/user_manager.dart';
import 'collection_task/bloc/inventory_collect_bloc.dart';
import 'collection_task/inventory_collect_page.dart';
import 'collection_task/repositories/inventory_collect_cache_repository.dart';
import 'services/inventory_task_service.dart';
import 'task_list/bloc/inventory_task_bloc.dart';
import 'task_list/inventory_task_list_page.dart';
import 'task_receive/bloc/inventory_receive_bloc.dart';
import 'task_receive/inventory_task_receive_page.dart';
import 'task_list/models/inventory_task.dart';

class InventoryTaskModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<InventoryTaskService>(
      () => InventoryTaskService(i.get<DioClient>().dio),
    );

    i.add<InventoryTaskBloc>(
      () => InventoryTaskBloc(
        taskService: i.get<InventoryTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<InventoryReceiveBloc>(
      () => InventoryReceiveBloc(
        taskService: i.get<InventoryTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<InventoryCollectBloc>(
      () => InventoryCollectBloc(
        service: i.get<InventoryTaskService>(),
        cacheRepository: InventoryCollectCacheRepository(Hive),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<InventoryTaskBloc>(),
        child: const InventoryTaskListPage(),
      ),
    );

    r.child(
      '/list',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<InventoryTaskBloc>(),
        child: const InventoryTaskListPage(),
      ),
    );

    r.child(
      '/collect/:checkTaskNo',
      child: (_) {
        final data = Modular.args.data as Map? ?? {};
        final task = data['task'] as InventoryTask?;
        if (task == null) {
          return const _TodoPlaceholder(title: '缺少任务信息，无法进入盘点采集');
        }
        return BlocProvider(
          create: (_) => Modular.get<InventoryCollectBloc>(),
          child: InventoryCollectPage(task: task),
        );
      },
    );

    r.child(
      '/receive',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<InventoryReceiveBloc>(),
        child: const InventoryTaskReceivePage(),
      ),
    );
  }
}

class _TodoPlaceholder extends StatelessWidget {
  const _TodoPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title\n请检查路由参数是否完整。',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
