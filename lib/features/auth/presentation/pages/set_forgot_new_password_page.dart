import 'package:college_project/core/utils/password_string_validator.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_state.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetForgotNewPasswordPage extends StatefulWidget {
  final String email;

  const SetForgotNewPasswordPage({super.key, required this.email});

  @override
  State<SetForgotNewPasswordPage> createState() =>
      _SetForgotNewPasswordPageState();
}

class _SetForgotNewPasswordPageState extends State<SetForgotNewPasswordPage> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    context.read<SetForgotNewPasswordBloc>().add(
      SetForgotNewPasswordSubmitted(widget.email, _controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Enter the New Password'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<SetForgotNewPasswordBloc, SetForgotNewPasswordState>(
            builder: (context, state) {
              if (state is SetForgotNewPasswordLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is SetForgotNewPasswordSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                    (route) => false,
                  );
                });
              }
              return Column(
                spacing: 10,
                children: [
                  Text(
                    'Create a password with a least 8 letters. It should be at least one capital, one small, one number, one special character.',

                    style: TextStyle(fontSize: 15),
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    placeholder: 'New Password',
                    controller: _controller,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('Next'),
                      onPressed: () {
                        final s = _controller.text;
                        if (s.length >= 8 &&
                            PasswordStringValidator().hasLowercase(s) &&
                            PasswordStringValidator().hasUppercase(s) &&
                            PasswordStringValidator().hasNumber(s) &&
                            PasswordStringValidator().hasSpecialCharacter(s)) {
                          _onSubmit();
                        } else {
                          ErrorPopup.show(
                            context,
                            '${PasswordStringValidator().validatePassword(s)}',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),
                ],
              );
            },
            listener: (BuildContext context, SetForgotNewPasswordState state) {
              if (state is SetForgotNewPasswordFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
