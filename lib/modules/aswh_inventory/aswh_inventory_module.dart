import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../../services/dio_client.dart';
import '../../services/user_manager.dart';
import 'collection_task/aswh_inventory_collect_page.dart';
import 'collection_task/bloc/aswh_inventory_collect_bloc.dart';
import 'collection_task/collect_detail/aswh_inventory_collect_detail_page.dart';
import 'collection_task/collect_detail/bloc/aswh_inventory_collect_detail_bloc.dart';
import 'collection_task/repositories/inventory_collect_cache_repository.dart';
import 'collection_task/services/aswh_inventory_collect_service.dart';
import 'command_list/aswh_inventory_command_page.dart';
import 'command_list/bloc/aswh_inventory_command_bloc.dart';
import 'command_list/services/aswh_inventory_command_service.dart';
import 'pallet_item/aswh_inventory_pallet_item_page.dart';
import 'pallet_item/bloc/aswh_inventory_pallet_item_bloc.dart';
import 'pallet_item/services/aswh_inventory_pallet_service.dart';
import 'services/aswh_inventory_task_service.dart';
import 'task_list/aswh_inventory_task_list_page.dart';
import 'task_list/bloc/aswh_inventory_task_list_bloc.dart';
import 'task_receive/aswh_inventory_receive_page.dart';
import 'task_receive/bloc/aswh_inventory_receive_bloc.dart';

class AswhInventoryModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<AswhInventoryTaskService>(
      () => AswhInventoryTaskService(i.get<DioClient>().dio),
    );

    i.addSingleton<AswhInventoryCollectService>(
      () => AswhInventoryCollectService(i.get<DioClient>().dio),
    );

    i.addSingleton<AswhInventoryCommandService>(
      () => AswhInventoryCommandService(i.get<DioClient>().dio),
    );

    i.addSingleton<AswhInventoryPalletService>(
      () => AswhInventoryPalletService(i.get<DioClient>().dio),
    );

    i.addSingleton<InventoryCollectCacheRepository>(
      InventoryCollectCacheRepository.new,
    );

    i.add<AswhInventoryTaskListBloc>(
      () => AswhInventoryTaskListBloc(
        taskService: i.get<AswhInventoryTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<AswhInventoryCollectBloc>(
      () => AswhInventoryCollectBloc(
        collectService: i.get<AswhInventoryCollectService>(),
        cacheRepository: i.get<InventoryCollectCacheRepository>(),
      ),
    );

    i.add<AswhInventoryCollectDetailBloc>(
      () => AswhInventoryCollectDetailBloc(
        cacheRepository: i.get<InventoryCollectCacheRepository>(),
      ),
    );

    i.add<AswhInventoryReceiveBloc>(
      () => AswhInventoryReceiveBloc(
        taskService: i.get<AswhInventoryTaskService>(),
        userManager: i.get<UserManager>(),
      ),
    );

    i.add<AswhInventoryCommandBloc>(
      () => AswhInventoryCommandBloc(
        commandService: i.get<AswhInventoryCommandService>(),
      ),
    );

    i.add<AswhInventoryPalletItemBloc>(
      () => AswhInventoryPalletItemBloc(
        service: i.get<AswhInventoryPalletService>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryTaskListBloc>(),
        child: const AswhInventoryTaskListPage(),
      ),
    );

    r.child(
      '/collect/:taskId',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryCollectBloc>(),
        child: const AswhInventoryCollectPage(),
      ),
    );

    r.child(
      '/collect/result',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryCollectDetailBloc>(),
        child: const AswhInventoryCollectDetailPage(),
      ),
    );

    r.child(
      '/receive',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryReceiveBloc>(),
        child: const AswhInventoryReceivePage(),
      ),
    );

    r.child(
      '/commands',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryCommandBloc>(),
        child: const AswhInventoryCommandPage(),
      ),
    );

    r.child(
      '/commands/checkorder',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryCommandBloc>(),
        child: const AswhInventoryCommandPage(),
      ),
    );

    r.child(
      '/pallet/:trayNo',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<AswhInventoryPalletItemBloc>(),
        child: const AswhInventoryPalletItemPage(),
      ),
    );
  }
}
