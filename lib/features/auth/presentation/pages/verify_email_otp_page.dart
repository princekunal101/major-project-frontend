import 'dart:async';

import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_state.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_state.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/auth/presentation/widgets/success_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailOtpPage extends StatefulWidget {
  final String email;

  const VerifyEmailOtpPage({super.key, required this.email});

  @override
  State<VerifyEmailOtpPage> createState() => _VerifyEmailOtpPageState();
}

class _VerifyEmailOtpPageState extends State<VerifyEmailOtpPage> {
  final confirmationCodeController = TextEditingController();
  int secondsRemaining = 0;
  Timer? _timer;

  void _onOtpSubmit() {
    context.read<VerifyOtpBloc>().add(
      VerifyOtpSubmitted(widget.email, confirmationCodeController.text.trim()),
    );
  }

  void _onResendOtpSubmit() {
    context.read<ResendOtpBloc>().add(ResendOtpSubmitted(widget.email));
  }

  void _startTimer(String time) {
    _timer?.cancel();
    setState(() {
      secondsRemaining = (int.tryParse(time) ?? 0) ~/ 1000;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void initState() {
    // secondsRemaining = 90;
    // _startTimer('90');
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsRemaining ~/ 60).toString();
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Enter the Confirmation Code'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: Stack(
            children: [
              BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                builder: (context, state) {
                  if (state is VerifyOtpLoading) {
                    return Center(child: CupertinoActivityIndicator());
                  }

                  if (state is VerifyOtpSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/set-password',
                        (route) => false,
                        arguments: widget.email,
                      );
                    });
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Text(
                        'To confirm your account, enter the 6-digit code',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.email,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CupertinoTextField(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        placeholder: 'Confirmation code',
                        controller: confirmationCodeController,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text('Next'),
                          onPressed: () {
                            if (confirmationCodeController.text.trim().length ==
                                6) {
                              _onOtpSubmit();
                            } else {
                              ErrorPopup.show(context, 'Enter the valid OTP');
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.tinted(
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text('Resend'),
                          onPressed: () {
                            _onResendOtpSubmit();
                          },
                        ),
                      ),
                      secondsRemaining != 0
                          ? SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Resend in $minutes:$seconds',
                                  style: TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.tinted(
                          sizeStyle: CupertinoButtonSize.medium,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                          },
                          child: Text('I already have an account'),
                        ),
                      ),
                    ],
                  );
                },
                listener: (BuildContext context, state) {
                  if (state is VerifyOtpFailure) {
                    ErrorPopup.show(context, state.message);
                  }
                },
              ),
              BlocConsumer<ResendOtpBloc, ResendOtpState>(
                builder: (context, state) {
                  if (state is ResendOtpLoading) {
                    return Center(child: CupertinoActivityIndicator());
                  }
                  return Container();
                },
                listener: (BuildContext context, state) {
                  if (state is ResendOtpFailure) {
                    ErrorPopup.show(context, state.message);
                  }
                  if (state is ResendOtpSuccess) {
                    _startTimer(state.response);
                    print(state.response);
                    SuccessPopup.show(
                      context,
                      'Otp has send to ${widget.email}',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
