import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_state.dart';
import 'package:college_project/features/auth/presentation/components/already_have_account_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetFullNamePage extends StatefulWidget {
  final String userId;

  const SetFullNamePage({super.key, required this.userId});

  @override
  State<SetFullNamePage> createState() => _SetFullNamePageState();
}

class _SetFullNamePageState extends State<SetFullNamePage> {
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    context.read<SetFullNameBloc>().add(
      SetFullNameSubmitted(widget.userId, _controller.text.trim()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Enter Your Full Name'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<SetFullNameBloc, SetFullNameState>(
            builder: (context, state) {
              if (state is SetFullNameLoading) {
                return Center(child: CupertinoActivityIndicator());
              }

              if (state is SetFullNameSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/set-username',
                    (route) => true,
                    arguments: widget.userId,
                  );
                });
              }
              return Column(
                spacing: 10,
                children: [
                  Text('Add your Full Name. It will shows to other users.'),
                  CupertinoTextField(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    placeholder: 'Full Name',
                    controller: _controller,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('Next'),
                      onPressed: () {
                        if (_controller.text.trim().length >= 2 ||
                            _controller.text.isNotEmpty) {
                          _onSubmit();
                        } else {
                          ErrorPopup.show(
                            context,
                            'Full Name must be greater than or equal to 2 letters.',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),

                  AlreadyHaveAccountButton(),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: CupertinoButton.tinted(
                  //     child: Text('I have already an account'),
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
            listener: (BuildContext context, SetFullNameState state) {
              if (state is SetFullNameFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
