import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_event.dart';
import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_state.dart';
import 'package:college_project/features/auth/presentation/components/already_have_account_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermPolicyPage extends StatefulWidget {
  final String userId;

  const TermPolicyPage({super.key, required this.userId});

  @override
  State<TermPolicyPage> createState() => _TermPolicyPageState();
}

class _TermPolicyPageState extends State<TermPolicyPage> {
  void _onSubmit() {
    context.read<AcceptedTermsBloc>().add(
      AcceptedTermsSubmitted(userId: widget.userId, acceptedTerms: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Terms and Policies')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AcceptedTermsBloc, AcceptedTermsState>(
            builder: (context, state) {
              if (state is AcceptedTermsLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (state is AcceptedTermsSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Navigator.pushReplacementNamed(context, '/dashboard');
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
                    'Agree to Community Study\'s terms and policies',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  RichText(
                    // textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        // letterSpacing: 1.0,
                        height: 1.4,
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'People who use our service may have uploaded your contact in formation to Community Study.',
                        ),
                        TextSpan(
                          text: ' Learn more ',
                          style: TextStyle(
                            color: CupertinoColors.link,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: '\n\nBy tapping '),
                        TextSpan(
                          text: 'I agree',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              ', you agree to create an account to Community Study\'s ',
                        ),
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            color: CupertinoColors.link,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text:
                              '. Learn how we collect, use and share your data in our ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: CupertinoColors.link,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text:
                              ' and how we use cookies and similar technology in our ',
                        ),
                        TextSpan(
                          text: 'Cookies Policy',
                          style: TextStyle(
                            color: CupertinoColors.link,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: '.\n\nThe '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: CupertinoColors.link,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text:
                              ' describe the ways we can use the information we collect when you create an account. For example, we use this information to provide, personalise and improve our products, including ads.',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('I agree'),
                      onPressed: () {
                        _onSubmit();
                      },
                    ),
                  ),

                  Spacer(),

                  AlreadyHaveAccountButton(),
                ],
              );
            },
            listener: (BuildContext context, AcceptedTermsState state) {
              if (state is AcceptedTermsFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
