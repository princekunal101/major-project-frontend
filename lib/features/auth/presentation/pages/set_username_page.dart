import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_state.dart';
import 'package:college_project/features/auth/presentation/components/already_have_account_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetUsernamePage extends StatefulWidget {
  final String userId;

  const SetUsernamePage({super.key, required this.userId});

  @override
  State<SetUsernamePage> createState() => _SetUsernamePageState();
}

class _SetUsernamePageState extends State<SetUsernamePage> {
  final TextEditingController _controller = TextEditingController();

  final allowedCharacter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9_.]'),
  );

  void _onSubmit() {
    context.read<SetUsernameBloc>().add(
      SetUsernameSubmitted(widget.userId, _controller.text.trim()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Create a username')),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<SetUsernameBloc, SetUsernameState>(
            builder: (context, state) {
              List<TextSpan> spans = [];

              if (state is SetUsernameLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is SetUsernameSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/term-policy',
                    (route) => false,
                    arguments: widget.userId,
                  );
                });
              }

              if (state is SetUsernameConflict) {
                spans.addAll([
                  TextSpan(text: 'Username '),
                  TextSpan(
                    text: _controller.text.trim(),
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                  TextSpan(text: ' is in use. Please try '),
                ]);

                spans.addAll(
                  state.suggestionModel.usernames.map(
                    (uname) => TextSpan(
                      text: '$uname ',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _controller.text = uname;
                        },
                    ),
                  ),
                );
              }
              return Column(
                spacing: 10,
                children: [
                  Text(
                    'Create your username. It will show to other and other can find you.',
                  ),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),

                    placeholder: 'username',
                    inputFormatters: [allowedCharacter],
                    controller: _controller,
                  ),

                  ?spans.isNotEmpty
                      ? SizedBox(
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: CupertinoColors.label.resolveFrom(
                                  context,
                                ),
                                height: 1.4,
                              ),
                              children: spans,
                            ),
                          ),
                        )
                      : null,

                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      onPressed: () {
                        if (_controller.text.trim().isNotEmpty &&
                            _controller.text.trim().length >= 2) {
                          _onSubmit();
                        }
                      },
                      child: Text('Next'),
                    ),
                  ),
                  Spacer(),

                  AlreadyHaveAccountButton(),
                ],
              );
            },
            listener: (BuildContext context, SetUsernameState state) {
              if (state is SetUsernameFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
