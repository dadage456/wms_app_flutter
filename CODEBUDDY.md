IMPORTANT: This file is for CodeBuddy Code. Follow it to operate effectively in this repository.

Project: Flutter app (wms_app)

Core dev commands
- Install deps: flutter pub get
- Run app (debug): flutter run
- Build Android APK: flutter build apk --release
- Build iOS: flutter build ios --release
- Analyze (lint): flutter analyze
- Format: dart format .
- Run all tests: flutter test
- Run single test: flutter test test/<file>_test.dart --plain-name "<name>"
- Codegen (freezed/json): dart run build_runner build --delete-conflicting-outputs
- Watch codegen: dart run build_runner watch --delete-conflicting-outputs

Environment
- Dart SDK: see pubspec.yaml (environment.sdk)
- Flutter version: use the version on your machine; no fvm config present

Architecture overview
- Dependency injection and routing: flutter_modular
  - AppModule configures singletons and routes: lib/app_module.dart
  - Feature module example: OutboundModule provides services and BLoCs and nested routes: lib/modules/outbound/outbound_module.dart
- State management: flutter_bloc
  - Example: LoginBloc handles login flow and emits states: lib/modules/home/login/bloc/login_bloc.dart
  - Outbound feature BLoCs under lib/modules/outbound/**/bloc
- Networking: dio wrapped by DioClient singleton for baseUrl, interceptors, token attach/refresh: lib/services/dio_client.dart
  - ApiResponseHandler centralizes response shape handling and Dio error extraction: lib/services/api_response_handler.dart
  - ApiService composes DioClient + UserManager, exposes login/getUserInfo/logout: lib/services/api_service.dart
- User/session: UserManager holds UserInfoModel and persisted login info via shared_preferences: lib/services/user_manager.dart
- UI
  - Entry: lib/main.dart starts ModularApp with MaterialApp.router
  - Home screen and navigation into feature modules: lib/modules/home/home_page.dart
  - Outbound feature pages and widgets live under lib/modules/outbound/**
- Models and codegen: freezed + json_serializable output files (*.freezed.dart, *.g.dart) checked in under lib/models and feature model folders

Conventions
- Lints: analysis_options.yaml includes flutter_lints
- Generated files (*.freezed.dart, *.g.dart) should not be manually edited; run codegen after changing models or Freezed unions
- Routing paths: root '/', '/login', '/home', feature base '/outbound' with nested '/detail/:id', '/collect/:no'

Common workflows
- After pulling changes: flutter pub get; dart run build_runner build --delete-conflicting-outputs; flutter analyze; flutter test
- Adding/altering models or Freezed unions: update source, then run codegen (build or watch)
- Working on outbound feature: use Modular.to.pushNamed('/outbound') from home; nested routes managed by OutboundModule

Notes from README
- The top-level README is the default Flutter template; refer here for concrete commands and architecture.
