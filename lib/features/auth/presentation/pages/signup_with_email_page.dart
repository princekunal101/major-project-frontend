import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_event.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_state.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupWithEmailPage extends StatefulWidget {
  const SignupWithEmailPage({super.key});

  @override
  State<SignupWithEmailPage> createState() => _SignupWithEmailPageState();
}

class _SignupWithEmailPageState extends State<SignupWithEmailPage> {
  final emailController = TextEditingController();

  void _onSubmit() {
    context.read<EmailSignupBloc>().add(
      SignupEmailSubmitted(email: emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Enter your Email Address'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<EmailSignupBloc, EmailSignupState>(
            builder: (context, state) {
              if (state is EmailSignupLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is EmailSignupSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(
                    context,
                    '/verify-email-otp',
                    arguments: emailController.text.trim(),
                  );
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  Text(
                    'Enter the email address which you can be contact. No one will see this on your profile.',
                    style: TextStyle(fontSize: 14),
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    placeholder: 'Email address',
                    controller: emailController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('Next'),
                      onPressed: () => {
                        if (emailController.text.trim().isNotEmpty) _onSubmit(),
                      },
                    ),
                  ),
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
            listener: (context, state) {
              if (state is EmailSignupFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
