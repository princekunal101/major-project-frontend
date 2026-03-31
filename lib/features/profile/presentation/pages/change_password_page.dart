import 'package:college_project/core/utils/password_string_validator.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_event.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  final String username;

  const ChangePasswordPage({super.key, required this.username});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  bool isButtonEnabled = false;

  late bool _obscure1 = true;
  late bool _obscure2 = true;
  late bool _obscure3 = true;

  void onSubmit() {
    context.read<ChangePasswordBloc>().add(
      ChangePasswordSubmitted(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      ),
    );
  }

  void checkIsButtonEnabled() {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Edit Profile',
        middle: Text(widget.username),
        trailing: CupertinoButton(
          padding: EdgeInsetsDirectional.all(0),
          onPressed: isButtonEnabled
              ? () {
                  // onSubmit();
                  final s = newPasswordController.text;
                  final confirmPassword = confirmNewPasswordController.text;

                  if (s == confirmPassword &&
                      s.length >= 8 &&
                      PasswordStringValidator().hasLowercase(s) &&
                      PasswordStringValidator().hasUppercase(s) &&
                      PasswordStringValidator().hasNumber(s) &&
                      PasswordStringValidator().hasSpecialCharacter(s)) {
                    onSubmit();
                  } else {
                    if (s != confirmPassword) {
                      ErrorPopup.show(context, 'Password Not Matched');
                    } else {
                      ErrorPopup.show(
                        context,
                        '${PasswordStringValidator().validatePassword(s)}',
                      );
                    }
                  }
                }
              : null,
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      child: SafeArea(
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            if (state is ChangePasswordLoading) {
              return Center(child: CupertinoActivityIndicator());
            }

            return Column(
              children: [
                CupertinoListSection(
                  topMargin: 4,
                  header: Text('Enter your Old Password'),
                  children: [
                    CupertinoTextField.borderless(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      placeholder: 'Old Password',
                      controller: oldPasswordController,
                      obscureText: _obscure1,
                      suffix: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();

                          setState(() {
                            _obscure1 = !_obscure1;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Icon(
                            _obscure1
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                            color: CupertinoColors.systemGrey3,
                            size: 20,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        checkIsButtonEnabled();
                      },
                    ),
                  ],
                ),
                CupertinoListSection(
                  hasLeading: false,
                  topMargin: 4,
                  header: Text(
                    'Create a password with a least 8 letters. It should be at least one capital, one small, one number, one special character.',
                  ),
                  children: [
                    CupertinoTextField.borderless(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      placeholder: 'New Password',
                      controller: newPasswordController,
                      obscureText: _obscure2,
                      suffix: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();

                          setState(() {
                            _obscure2 = !_obscure2;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Icon(
                            _obscure2
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                            color: CupertinoColors.systemGrey3,
                            size: 20,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        checkIsButtonEnabled();
                      },
                    ),
                    CupertinoTextField.borderless(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      placeholder: 'Confirm New Password',
                      controller: confirmNewPasswordController,
                      obscureText: _obscure3,
                      suffix: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();

                          setState(() {
                            _obscure3 = !_obscure3;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Icon(
                            _obscure3
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                            color: CupertinoColors.systemGrey3,
                            size: 20,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        checkIsButtonEnabled();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
          listener: (BuildContext context, ChangePasswordState state) {
            if (state is ChangePasswordSuccess) {
              Navigator.pop(context);
            }

            if (state is ChangePasswordFailure) {
              ErrorPopup.show(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
