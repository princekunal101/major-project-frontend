import 'package:college_project/core/constants/image_string.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_event.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _submit() {
    context.read<LoginBloc>().add(
      LoginEmailPasswordSubmitted(
        emailController.text,
        passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is LoginFailure) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is LoginSuccess) Navigator.pushNamed(context, '/');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Image(
                    height: 150,
                    width: 150,
                    image: AssetImage(CSImageFile.lightAppLogo),
                  ),
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email',
                  ),
                  CupertinoTextField(
                    controller: passwordController,
                    obscureText: true,
                    placeholder: 'Password',
                  ),
                  CupertinoButton.filled(
                    sizeStyle: CupertinoButtonSize.medium,
                    onPressed: () {
                      _submit();
                    },
                    child: Text('Login'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
