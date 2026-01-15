import 'package:college_project/core/constants/image_string.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_event.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_state.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (state is LoginSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Navigator.pushReplacementNamed(context, '/dashboard');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                    (route) => false,
                  );
                });
              }
              ;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image(
                      height: 70,
                      width: 70,
                      image: AssetImage(CSImageFile.appLogoLight),
                    ),
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    controller: emailController,
                    placeholder: 'Username or Email',
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    controller: passwordController,
                    obscureText: _obscure,
                    placeholder: 'Password',
                    suffix: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();

                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Icon(
                          _obscure
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_fill,
                          color: CupertinoColors.systemGrey3,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      onPressed: () {
                        if (emailController.text.trim().isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          _submit();
                        }
                      },
                      child: Text('Log in'),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      // foregroundColor: CupertinoDynamicColor.withBrightness(
                      //   color: CupertinoColors.systemRed,
                      //   darkColor: CupertinoColors.white,
                      // ),
                      sizeStyle: CupertinoButtonSize.medium,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forgot-password'),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.tinted(
                      sizeStyle: CupertinoButtonSize.medium,
                      onPressed: () {
                        Navigator.pushNamed(context, '/send-email-otp');
                      },
                      child: Text('Create new account'),
                    ),
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
