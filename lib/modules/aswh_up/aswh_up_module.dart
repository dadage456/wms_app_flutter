import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import '../../services/user_manager.dart';
import 'collection_task/aswh_up_collection_page.dart';
import 'collection_task/aswh_up_collection_result_page.dart';
import 'collection_task/aswh_up_pallet_item_page.dart';
import 'collection_task/aswh_up_wcs_instruction_page.dart';
import 'collection_task/bloc/aswh_up_collection_bloc.dart';
import 'collection_task/bloc/aswh_up_pallet_item_cubit.dart';
import 'collection_task/bloc/aswh_up_wcs_instruction_cubit.dart';
import 'models/aswh_up_collection_models.dart';
import 'models/aswh_up_task.dart';
import 'services/aswh_up_task_service.dart';
import 'task_details/aswh_up_task_detail_page.dart';
import 'task_details/bloc/aswh_up_task_detail_bloc.dart';
import 'task_list/aswh_up_task_list_page.dart';
import 'task_list/bloc/aswh_up_task_bloc.dart';
import 'task_receive/aswh_up_receive_detail_page.dart';
import 'task_receive/aswh_up_receive_page.dart';
import 'task_receive/bloc/aswh_up_receive_bloc.dart';
import 'task_receive/bloc/aswh_up_receive_detail_bloc.dart';
import 'widgets/todo_placeholder.dart';

class AswhUpModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<AswhUpTaskService>(
      () => AswhUpTaskService(i.get<DioClient>().dio),
    );

    i.add<AswhUpTaskBloc>(
      () => AswhUpTaskBloc(
        taskService: i.get<AswhUpTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<AswhUpTaskDetailBloc>(
      () => AswhUpTaskDetailBloc(
        i.get<AswhUpTaskService>(),
        i.get<UserManager>(),
      ),
    );

    i.add<AswhUpReceiveBloc>(
      () => AswhUpReceiveBloc(
        taskService: i.get<AswhUpTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<AswhUpReceiveDetailBloc>(
      () => AswhUpReceiveDetailBloc(
        i.get<AswhUpTaskService>(),
        i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<AswhUpTaskBloc>(),
        child: const AswhUpTaskListPage(),
      ),
    );

    r.child(
      '/list',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<AswhUpTaskBloc>(),
        child: const AswhUpTaskListPage(),
      ),
    );

    r.child(
      '/detail/:taskId',
      child: (_) {
        final params = Modular.args.params;
        final taskId = int.tryParse(params['taskId'] ?? '') ?? 0;
        final data = Modular.args.data as Map? ?? {};
        final workStation = data['workStation'] as String?;
        return BlocProvider(
          create: (_) => Modular.get<AswhUpTaskDetailBloc>(),
          child: AswhUpTaskDetailPage(taskId: taskId, workStation: workStation),
        );
      },
    );

    r.child(
      '/collect/:taskNo',
      child: (_) {
        final data = Modular.args.data as Map? ?? {};
        final task = data['task'] as AswhUpTask?;
        if (task == null) {
          return const TodoPlaceholderPage(title: '缺少任务信息');
        }
        return BlocProvider(
          create: (_) => AswhUpCollectionBloc(
            task: task,
            service: Modular.get<AswhUpTaskService>(),
          ),
          child: const AswhUpCollectionPage(),
        );
      },
    );

    r.child(
      '/collect/result',
      child: (_) {
        final args = Modular.args.data;
        List<AswhUpCollectionStock> stocks = const [];
        if (args is Map && args['stocks'] is List<AswhUpCollectionStock>) {
          stocks = List<AswhUpCollectionStock>.from(args['stocks']);
        } else if (args is List<AswhUpCollectionStock>) {
          stocks = List<AswhUpCollectionStock>.from(args);
        }
        return AswhUpCollectionResultPage(initialStocks: stocks);
      },
    );

    r.child(
      '/receive',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<AswhUpReceiveBloc>(),
        child: const AswhUpReceivePage(),
      ),
    );

    r.child(
      '/receive/detail/:taskId',
      child: (_) {
        final params = Modular.args.params;
        final taskId = int.tryParse(params['taskId'] ?? '') ?? 0;
        final data = Modular.args.data as Map? ?? {};
        final workStation = data['workStation'] as String?;
        return BlocProvider(
          create: (_) => Modular.get<AswhUpReceiveDetailBloc>(),
          child: AswhUpReceiveDetailPage(
            taskId: taskId,
            workStation: workStation,
          ),
        );
      },
    );

    r.child(
      '/pallet-item',
      child: (_) {
        final data = Modular.args.data as Map? ?? {};
        final trayNo = (data['trayNo'] ?? '') as String;
        if (trayNo.isEmpty) {
          return const TodoPlaceholderPage(title: '缺少托盘号');
        }
        return BlocProvider(
          create: (_) => AswhUpPalletItemCubit(
            service: Modular.get<AswhUpTaskService>(),
            trayNo: trayNo,
          ),
          child: const AswhUpPalletItemPage(),
        );
      },
    );

    r.child(
      '/wcs-instruction',
      child: (_) {
        final data = Modular.args.data as Map? ?? {};
        final taskId = data['taskId'] as int?;
        final taskComment = data['taskComment'] as String?;
        final taskType = data['taskType'] as String?;
        if (taskId == null || taskComment == null || taskType == null) {
          return const TodoPlaceholderPage(title: '缺少指令查询参数');
        }
        return BlocProvider(
          create: (_) => AswhUpWcsInstructionCubit(
            service: Modular.get<AswhUpTaskService>(),
            taskComment: taskComment,
            taskId: taskId,
            taskType: taskType,
          ),
          child: const AswhUpWcsInstructionPage(),
        );
      },
    );
  }
}
