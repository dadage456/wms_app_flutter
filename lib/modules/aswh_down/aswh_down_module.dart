import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/app_module.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/online_pick_collection_page.dart';
import 'package:wms_app/modules/aswh_down/collection_task/online_pick_collection_result_page.dart';
import 'package:wms_app/services/dio_client.dart';
import 'package:wms_app/services/user_manager.dart';

import 'services/aswh_down_collection_service.dart';
import 'services/aswh_down_task_service.dart';
import 'models/online_pick_task_models.dart';
import 'models/online_pick_collection_models.dart';
import 'task_details/bloc/online_pick_task_detail_bloc.dart';
import 'task_details/pages/online_pick_task_detail_page.dart';
import 'task_list/bloc/online_pick_task_bloc.dart';
import 'task_list/pages/online_pick_task_list_page.dart';
import 'task_receive/bloc/online_pick_receive_bloc.dart';
import 'task_receive/bloc/online_pick_receive_detail_bloc.dart';
import 'task_receive/pages/online_pick_receive_detail_page.dart';
import 'task_receive/pages/online_pick_receive_page.dart';
import 'wcs/bloc/online_pick_wcs_bloc.dart';
import 'wcs/pages/online_pick_wcs_page.dart';

/// 自动化仓库在线拣选模块（AS/RS Outbound）
class AswhDownModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    // Services
    i.addSingleton<AswhDownTaskService>(
      () => AswhDownTaskService(i.get<DioClient>().dio),
    );
    i.addSingleton<AswhDownCollectionService>(
      () => AswhDownCollectionService(i.get<DioClient>().dio),
    );

    // Blocs
    i.add<OnlinePickTaskBloc>(
      () => OnlinePickTaskBloc(
        taskService: i.get<AswhDownTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );
    i.add<OnlinePickTaskDetailBloc>(
      () => OnlinePickTaskDetailBloc(
        taskService: i.get<AswhDownTaskService>(),
        collectionService: i.get<AswhDownCollectionService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<OnlinePickCollectionBloc>(
      () => OnlinePickCollectionBloc(
        collectionService: i.get<AswhDownCollectionService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<OnlinePickReceiveBloc>(
      () => OnlinePickReceiveBloc(
        taskService: i.get<AswhDownTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );
    i.add<OnlinePickReceiveDetailBloc>(
      () => OnlinePickReceiveDetailBloc(
        taskService: i.get<AswhDownTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );
    i.add<OnlinePickWcsBloc>(
      () => OnlinePickWcsBloc(
        collectionService: i.get<AswhDownCollectionService>(),
        userManager: i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<OnlinePickTaskBloc>(),
        child: const OnlinePickTaskListPage(),
      ),
    );

    r.child(
      '/list',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<OnlinePickTaskBloc>(),
        child: const OnlinePickTaskListPage(),
      ),
    );

    r.child(
      '/detail/:outTaskId',
      child: (_) {
        final args = Modular.args;
        final params = args.params;
        final data = args.data as Map<String, dynamic>? ?? {};
        final task = data['task'];
        if (task is! OnlinePickTask) {
          throw ArgumentError('缺少在线拣选任务数据');
        }

        return BlocProvider(
          create: (_) => Modular.get<OnlinePickTaskDetailBloc>(),
          child: OnlinePickTaskDetailPage(task: task),
        );
      },
    );

    r.child(
      '/collect',
      child: (_) {
        final args = Modular.args.data as Map<String, dynamic>? ?? {};
        final task = args['task'];
        if (task is! OnlinePickTask) {
          throw ArgumentError('缺少在线拣选任务数据');
        }
        return BlocProvider(
          create: (_) => Modular.get<OnlinePickCollectionBloc>(),
          child: OnlinePickCollectionPage(task: task),
        );
      },
    );

    r.child(
      '/collect/result',
      child: (_) {
        final args = Modular.args.data as Map<String, dynamic>? ?? {};
        final stockPayload = args['stocks'] as List<dynamic>? ?? const [];
        final stocks = stockPayload
            .map(
              (item) => item is OnlinePickCollectionStock
                  ? item
                  : OnlinePickCollectionStock.fromJson(
                      Map<String, dynamic>.from(item as Map),
                    ),
            )
            .toList(growable: false);
        return OnlinePickCollectionResultPage(initialStocks: stocks);
      },
    );

    r.child(
      '/receive',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<OnlinePickReceiveBloc>(),
        child: const OnlinePickReceivePage(),
      ),
    );

    r.child(
      '/receive/detail/:outTaskId',
      child: (_) {
        final args = Modular.args;
        final params = args.params;
        final paramValue = params['outTaskId'] ?? '';
        final taskId = int.tryParse(paramValue) ?? 0;
        final data = args.data as Map<String, dynamic>? ?? {};

        return BlocProvider(
          create: (_) => Modular.get<OnlinePickReceiveDetailBloc>(),
          child: OnlinePickReceiveDetailPage(outTaskId: taskId, taskData: data),
        );
      },
    );

    r.child(
      '/wcs',
      child: (_) {
        final args = Modular.args.data as Map<String, dynamic>? ?? {};
        return BlocProvider(
          create: (_) => Modular.get<OnlinePickWcsBloc>(),
          child: OnlinePickWcsPage(initialArgs: args),
        );
      },
    );
  }
}
