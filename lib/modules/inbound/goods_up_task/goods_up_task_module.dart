import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_module.dart';
import '../../../../services/dio_client.dart';
import '../../../../services/user_manager.dart';
import 'bloc/goods_up_collection_bloc.dart';
import 'goods_up_collection_page.dart';
import 'services/goods_up_collection_service.dart';

class GoodsUpTaskModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<GoodsUpCollectionService>(
      () => GoodsUpCollectionService(i.get<DioClient>().dio),
    );

    i.add<GoodsUpCollectionBloc>(
      () => GoodsUpCollectionBloc(
        service: i.get<GoodsUpCollectionService>(),
        userManager: i.get<UserManager>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/collect',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<GoodsUpCollectionBloc>(),
        child: const GoodsUpCollectionPage(),
      ),
    );
  }
}
