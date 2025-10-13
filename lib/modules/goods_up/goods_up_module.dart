import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import '../../services/user_manager.dart';
import 'services/goods_up_task_service.dart';
import 'task_details/bloc/goods_up_task_detail_bloc.dart';
import 'task_details/goods_up_task_detail_page.dart';
import 'task_receive/bloc/inbound_receive_task_bloc.dart';
import 'task_receive/bloc/inbound_receive_task_detail_bloc.dart';
import 'task_receive/goods_up_receive_detail_page.dart';
import 'task_receive/goods_up_receive_page.dart';
import 'task_list/bloc/goods_up_task_bloc.dart';
import 'task_list/goods_up_task_list_page.dart';
import 'task_list/models/goods_up_task.dart';

class GoodsUpModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<GoodsUpTaskService>(
      () => GoodsUpTaskService(i.get<DioClient>().dio),
    );

    i.add<GoodsUpTaskBloc>(
      () => GoodsUpTaskBloc(
        taskService: i.get<GoodsUpTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<GoodsUpTaskDetailBloc>(
      () => GoodsUpTaskDetailBloc(
        i.get<GoodsUpTaskService>(),
        i.get<UserManager>(),
      ),
    );

    i.add<InboundReceiveTaskBloc>(
      () => InboundReceiveTaskBloc(
        taskService: i.get<GoodsUpTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<InboundReceiveTaskDetailBloc>(
      () => InboundReceiveTaskDetailBloc(
        i.get<GoodsUpTaskService>(),
        i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<GoodsUpTaskBloc>(),
        child: const GoodsUpTaskListPage(),
      ),
    );

    r.child(
      '/list',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<GoodsUpTaskBloc>(),
        child: const GoodsUpTaskListPage(),
      ),
    );

    r.child(
      '/detail/:inTaskId',
      child: (_) {
        final params = Modular.args.params;
        final data = Modular.args.data as Map? ?? {};
        final inTaskId = int.tryParse(params['inTaskId'] ?? '') ?? 0;
        final workStation = data['workStation'] as String?;
        return BlocProvider(
          create: (_) => Modular.get<GoodsUpTaskDetailBloc>(),
          child: GoodsUpTaskDetailPage(
            inTaskId: inTaskId,
            workStation: workStation,
          ),
        );
      },
    );

    r.child(
      '/receive',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<InboundReceiveTaskBloc>(),
        child: const GoodsUpReceivePage(),
      ),
    );

    r.child(
      '/receive/detail/:inTaskId',
      child: (_) {
        final task = (Modular.args.data as Map?)?['task'] as GoodsUpTask?;
        if (task == null) {
          return const _TodoPlaceholder(title: '缺少任务信息，无法查看接收明细');
        }
        return BlocProvider(
          create: (_) => Modular.get<InboundReceiveTaskDetailBloc>(),
          child: GoodsUpReceiveDetailPage(task: task),
        );
      },
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
          '$title\n请参见 TODO 文档了解实现进度。',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
