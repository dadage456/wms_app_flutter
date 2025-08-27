import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/pages/login/bloc/login_event.dart';
import 'package:wms_app/pages/login/bloc/login_state.dart';
import 'package:wms_app/services/api_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  final UserManager userManager;

  LoginBloc({required this.apiService, required this.userManager})
    : super(LoginInitial()) {
    on<LoginButtonTap>((event, emit) async {
      // 验证用户名和密码不为空
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(const LoginFailure(error: '账号和密码不能为空'));
        return;
      }

      emit(LoginLoading());

      try {
        await apiService.login(event.username, event.password);
        emit(LoginSuccess());
      } catch (error) {
        emit(LoginFailure(error: '登录失败：${error.toString()}'));
      }
    });
  }
}
