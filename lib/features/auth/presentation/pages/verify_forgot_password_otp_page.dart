import 'dart:async';

import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_state.dart';
import 'package:college_project/features/auth/presentation/components/back_to_login_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyForgotPasswordOtpPage extends StatefulWidget {
  final String emailId;

  const VerifyForgotPasswordOtpPage({super.key, required this.emailId});

  @override
  State<VerifyForgotPasswordOtpPage> createState() =>
      _VerifyForgotPasswordOtpPageState();
}

class _VerifyForgotPasswordOtpPageState
    extends State<VerifyForgotPasswordOtpPage> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    context.read<VerifyForgottenPasswordOtpBloc>().add(
      VerifyForgottenPasswordOtpSubmitted(
        widget.emailId,
        _controller.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Enter confirmation code'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child:
              BlocConsumer<
                VerifyForgottenPasswordOtpBloc,
                VerifyForgottenPasswordOtpState
              >(
                builder: (context, state) {
                  if (state is VerifyForgottenPasswordOtpLoading) {
                    return Center(child: CupertinoActivityIndicator());
                  }

                  if (state is VerifyForgottenPasswordOtpSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/set-new-password',
                        (route) => false,
                        arguments: widget.emailId,
                      );
                    });
                  }
                  return Column(
                    spacing: 10,
                    children: [
                      Text(
                        'To confirm your account, enter the 6-digit code',
                        style: TextStyle(fontSize: 15),
                      ),
                      CupertinoTextField(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        placeholder: 'Confirmation code',
                        controller: _controller,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text('Next'),
                          onPressed: () {
                            if (_controller.text.trim().length == 6) {
                              _onSubmit();
                            } else {
                              ErrorPopup.show(context, 'Enter the valid OTP');
                            }
                          },
                        ),
                      ),

                      Spacer(),

                      BackToLoginButton(),
                    ],
                  );
                },
                listener:
                    (
                      BuildContext context,
                      VerifyForgottenPasswordOtpState state,
                    ) {
                      if (state is VerifyForgottenPasswordOtpFailure) {
                        ErrorPopup.show(context, state.message);
                      }
                    },
              ),
        ),
      ),
    );
  }
}
