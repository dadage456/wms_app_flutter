import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import 'collection_task/bloc/mtl_senter_collection_bloc.dart';
import 'collection_task/mtl_senter_collection_page.dart';
import 'collection_task/services/mtl_senter_service.dart';
import 'collection_task/models/mtl_senter_models.dart';

class MtlSenterModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<MtlSenterService>(
      () => MtlSenterService(i.get<DioClient>().dio),
    );

    i.add<MtlSenterCollectionBloc>(
      () => MtlSenterCollectionBloc(service: i.get<MtlSenterService>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) {
        final args = Modular.args.data;
        final task = args is Map<String, dynamic>
            ? args['task'] as MtlSenterTask?
            : args is MtlSenterTask
                ? args
                : null;
        return BlocProvider(
          create: (_) => Modular.get<MtlSenterCollectionBloc>(),
          child: MtlSenterCollectionPage(task: task),
        );
      },
    );
  }
}
