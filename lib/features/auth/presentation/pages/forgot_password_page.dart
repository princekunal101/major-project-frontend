import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_state.dart';
import 'package:college_project/features/auth/presentation/components/back_to_login_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    context.read<ForgottenPasswordBloc>().add(
      ForgottenPasswordSubmitted(
        email: _controller.text.trim(),
        isOtpMode: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Trouble with logging in?'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<ForgottenPasswordBloc, ForgottenPasswordState>(
            builder: (context, state) {
              if (state is ForgottenPasswordLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is ForgottenPasswordSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Navigator.pushReplacementNamed(context, '/dashboard');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/verify-otp-forget-password',
                    (route) => false,
                    arguments: _controller.text.trim(),
                  );
                });
              }
              return Column(
                spacing: 10,
                children: [
                  Text(
                    'Enter your username or email address and we\'ll send you otp account verification.',
                    style: TextStyle(fontSize: 15),
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    placeholder: 'Username or email address',
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      onPressed: () {
                        _onSubmit();
                      },
                      child: Text('Next'),
                    ),
                  ),
                  Spacer(),
                  BackToLoginButton(),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: CupertinoButton(
                  //     child: Text(
                  //       'Back to login',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pushNamedAndRemoveUntil(
                  //         context,
                  //         '/login',
                  //         (route) => false,
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              );
            },
            listener: (BuildContext context, ForgottenPasswordState state) {
              if (state is ForgottenPasswordFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
