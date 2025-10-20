import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import '../goods_up/services/goods_up_task_service.dart';
import 'collection_task/bloc/transfer_collection_bloc.dart';
import 'collection_task/transfer_collection_page.dart';
import 'services/transfer_task_service.dart';

class TransferModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<TransferTaskService>(
      () => TransferTaskService(
        i.get<DioClient>().dio,
        GoodsUpTaskService(i.get<DioClient>().dio),
      ),
    );

    i.add<TransferCollectionBloc>(
      () => TransferCollectionBloc(service: i.get<TransferTaskService>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<TransferCollectionBloc>(),
        child: const TransferCollectionPage(),
      ),
    );
  }
}
