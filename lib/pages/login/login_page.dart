import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wms_app/common/user_manager.dart';
import 'package:wms_app/pages/login/bloc/login_bloc.dart';
import 'package:wms_app/pages/login/bloc/login_event.dart';
import 'package:wms_app/pages/login/bloc/login_state.dart';
import 'package:wms_app/services/api_service.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        apiService: ApiService(),
        userManager: UserManager(),
      ),
      child: const _UserLoginPageView(),
    );
  }
}

class _UserLoginPageView extends HookWidget {
  const _UserLoginPageView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accountController = useTextEditingController(text: 'TX001');
    final passwordController = useTextEditingController();
    final obscure = useState<bool>(true);

    // 控制加载对话框
    final isDialogShowing = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          // 登录中：展示加载对话框
          if (state is LoginLoading) {
            if (!isDialogShowing.value) {
              isDialogShowing.value = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return;
          }

          // 关闭加载对话框（如果打开了）
          if (isDialogShowing.value) {
            Navigator.of(context, rootNavigator: true).pop();
            isDialogShowing.value = false;
          }

          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('登录成功')),
            );
            // 登录成功后跳转到主页面
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          
          //用于测试
          Future.delayed(Duration(seconds: 5)).then((value){
            Navigator.of(context).pushReplacementNamed('/home');
          });
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  '你好，',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '欢迎登录金风科技WMS',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),

                // 账号
                Text(
                  '账号',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: accountController,
                  style: theme.textTheme.titleLarge,
                  decoration: const InputDecoration(
                    hintText: '请输入账号',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const Divider(height: 1, thickness: 1.5),
                const SizedBox(height: 32),

                // 密码
                Text(
                  '密码',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: obscure.value,
                  style: theme.textTheme.titleLarge,
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    suffixIcon: IconButton(
                      onPressed: () => obscure.value = !obscure.value,
                      icon: Icon(
                        obscure.value ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 1.5),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      '忘记密码？',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is LoginLoading
                            ? null
                            : () {
                                final account = accountController.text.trim();
                                final password = passwordController.text;

                                context.read<LoginBloc>().add(
                                      LoginButtonTap(
                                        username: account,
                                        password: password,
                                      ),
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A69FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: state is LoginLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                '登录',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
