import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/modules/home/home_page.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'modules/home/login/login_page.dart';
import 'app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OutTaskItemAdapter());
  Hive.registerAdapter(BarcodeContentAdapter());
  Hive.registerAdapter(CollectionStockAdapter());
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '金风WMS应用',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
