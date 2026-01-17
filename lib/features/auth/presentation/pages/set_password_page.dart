import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_state.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetPasswordPage extends StatefulWidget {
  final String email;

  const SetPasswordPage({super.key, required this.email});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final setPasswordController = TextEditingController();

  void _onSubmit() {
    context.read<SetPasswordBloc>().add(
      SetPasswordSubmitted(widget.email, setPasswordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Create Your Password'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<SetPasswordBloc, SetPasswordState>(
            builder: (context, state) {
              if (state is SetPasswordLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (state is SetPasswordSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/set-dob',
                    (route) => false,
                    arguments: state.response,
                  );
                });
              }
              return Column(
                spacing: 12,
                children: [
                  Text(
                    'Create a password with a least 8 letters. It should be at least one capital, one small, one number, one special character.',
                    style: TextStyle(fontSize: 14),
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    placeholder: 'Password',
                    controller: setPasswordController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('Next'),
                      onPressed: () {
                        final s = setPasswordController.text;
                        if (s.length >= 8 &&
                            hasLowercase(s) &&
                            hasUppercase(s) &&
                            hasNumber(s) &&
                            hasSpecialCharacter(s)) {
                          _onSubmit();
                        } else {
                          ErrorPopup.show(context, '${validatePassword(s)}');
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.tinted(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('I have already an account'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            listener: (BuildContext context, SetPasswordState state) {
              if (state is SetPasswordFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  // check String patterns
  bool hasUppercase(String s) => s.contains(RegExp(r'[A-Z]'));

  bool hasLowercase(String s) => s.contains(RegExp(r'[a-z]'));

  bool hasNumber(String s) => s.contains(RegExp(r'[0-9]'));

  bool hasSpecialCharacter(String s) => s.contains(RegExp(r'[@$#!%*?&]'));

  String? validatePassword(String password) {
    List<String> missing = [];

    final hasLower = hasLowercase(password);
    final hasUpper = hasUppercase(password);
    final hasNum = hasNumber(password);
    final hasSpecial = hasSpecialCharacter(password);

    if (password.length < 8) {
      return 'Password must be greater or equal to 8 characters';
    }

    if (!hasLower && !hasUpper && !hasNum && !hasSpecial) {
      return 'Password must contain at least one lowercase, one uppercase, one number and one special character.';
    }

    if (!hasLower) missing.add('one lowercase letter');
    if (!hasUpper) missing.add('one uppercase letter');
    if (!hasNum) missing.add('one number');
    if (!hasSpecial) missing.add('one special character');

    if (missing.isEmpty) return null;

    return 'Password must contain at least ${missing.join(' and ')}.';
  }
}
