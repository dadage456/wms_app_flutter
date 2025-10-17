import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import 'bloc/inventory_query_bloc.dart';
import 'pages/inventory_query_page.dart';
import 'services/inventory_query_service.dart';

class InventoryQueryModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<InventoryQueryService>(
      () => InventoryQueryService(i.get<DioClient>().dio),
    );

    i.add<InventoryQueryBloc>(
      () => InventoryQueryBloc(service: i.get<InventoryQueryService>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<InventoryQueryBloc>(),
        child: const InventoryQueryPage(),
      ),
    );
  }
}
