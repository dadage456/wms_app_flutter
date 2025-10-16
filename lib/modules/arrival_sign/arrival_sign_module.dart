import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/app_module.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/arrival_receive_page.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/detail/arrival_receive_detail_page.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/bloc/arrival_receive_bloc.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/arrival_collect_page.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/arrival_collect_result_page.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/bloc/arrival_collect_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_progress.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/services/arrival_collect_cache_repository.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/arrival_sign_detail_page.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_list/arrival_sign_task_list_page.dart';
import 'package:wms_app/modules/arrival_sign/task_list/bloc/arrival_sign_list_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';
import 'package:wms_app/services/dio_client.dart';
import 'package:wms_app/services/user_manager.dart';

class ArrivalSignModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<ArrivalSignService>(
      () => ArrivalSignService(i.get<DioClient>().dio),
    );

    i.addSingleton<ArrivalCollectCacheRepository>(
      ArrivalCollectCacheRepository.new,
    );

    i.add<ArrivalSignListBloc>(
      () => ArrivalSignListBloc(
        arrivalSignService: i.get<ArrivalSignService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<ArrivalSignDetailBloc>(
      () => ArrivalSignDetailBloc(
        service: i.get<ArrivalSignService>(),
      ),
    );

    i.add<ArrivalReceiveBloc>(
      () => ArrivalReceiveBloc(
        service: i.get<ArrivalSignService>(),
        userManager: i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ArrivalSignListBloc>(),
        child: const ArrivalSignTaskListPage(),
      ),
    );

    r.child(
      '/list',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ArrivalSignListBloc>(),
        child: const ArrivalSignTaskListPage(),
      ),
    );

    r.child(
      '/detail',
      child: (context) {
        final args = Modular.args;
        final arrivalsBillId =
            args.data?['arrivalsBillId'] ?? args.queryParams['arrivalsBillId'];
        if (arrivalsBillId == null || arrivalsBillId.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('缺少到货单ID参数')),
          );
        }
        return BlocProvider(
          create: (_) => Modular.get<ArrivalSignDetailBloc>(),
          child: ArrivalSignDetailPage(arrivalsBillId: arrivalsBillId),
        );
      },
    );

    r.child(
      '/receive',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ArrivalReceiveBloc>(),
        child: const ArrivalReceivePage(),
      ),
    );

    r.child(
      '/receive/detail',
      child: (context) {
        final args = Modular.args;
        final arrivalsBillId =
            args.data?['arrivalsBillId'] ?? args.queryParams['arrivalsBillId'];
        if (arrivalsBillId == null || arrivalsBillId.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('缺少到货单ID参数')),
          );
        }

        return BlocProvider(
          create: (_) => Modular.get<ArrivalSignDetailBloc>(),
          child: ArrivalReceiveDetailPage(arrivalsBillId: arrivalsBillId),
        );
      },
    );

    r.child(
      '/collect',
      child: (context) {
        final args = Modular.args.data;
        if (args is! Map) {
          return const Scaffold(
            body: Center(child: Text('缺少到货任务信息')),
          );
        }

        final taskJson = args['task'];
        if (taskJson is! Map<String, dynamic>) {
          return const Scaffold(
            body: Center(child: Text('缺少到货任务信息')),
          );
        }

        final task = ArrivalSignTask.fromJson(
          Map<String, dynamic>.from(taskJson),
        );

        return BlocProvider(
          create: (_) => ArrivalCollectBloc(
            service: Modular.get<ArrivalSignService>(),
            userManager: Modular.get<UserManager>(),
            cacheRepository: Modular.get<ArrivalCollectCacheRepository>(),
          ),
          child: ArrivalCollectPage(task: task),
        );
      },
    );

    r.child(
      '/collect/result',
      child: (context) {
        final args = Modular.args.data;
        List<Map<String, dynamic>> jsonList = const [];
        if (args is Map && args['progresses'] is List) {
          jsonList = (args['progresses'] as List)
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }

        final progresses = jsonList
            .map(ArrivalCollectProgress.fromJson)
            .toList(growable: false);

        return ArrivalCollectResultPage(progresses: progresses);
      },
    );
  }
}
