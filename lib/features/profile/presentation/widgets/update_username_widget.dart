import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';
import 'package:college_project/features/profile/domain/usecase/check_is_username_available.dart';
import 'package:college_project/features/profile/presentation/bloc/is_username_available_bloc/is_username_available_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/is_username_available_bloc/is_username_available_event.dart';
import 'package:college_project/features/profile/presentation/bloc/is_username_available_bloc/is_username_available_state.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUsernameWidget extends StatefulWidget {
  final String username;

  const UpdateUsernameWidget({super.key, required this.username});

  @override
  State<UpdateUsernameWidget> createState() => _UpdateUsernameWidgetState();
}

class _UpdateUsernameWidgetState extends State<UpdateUsernameWidget> {
  final SecureStorageService storageService = SecureStorageService();
  late final DioClient dioClient = DioClient(storageService);

  final TextEditingController _controller = TextEditingController();

  final allowedCharacter = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9_.]'),
  );

  bool isButtonEnabled = false;

  bool isAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.username;
  }

  void checkAvailability(String value) {
    context.read<IsUsernameAvailableBloc>().add(
      IsUsernameAvailableSubmitted(value),
    );
  }

  void checkButtonEnabled() {
    // setState(() {
    isButtonEnabled = widget.username != _controller.text.trim() && isAvailable
        ? true
        : false;
    // });
  }

  void onSubmit() {
    context.read<UpdateProfileBloc>().add(
      UpdateProfileSubmitted(username: _controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Edit Profile',
            middle: Text('Edit Username'),
            trailing: CupertinoButton(
              padding: EdgeInsetsDirectional.all(0),
              onPressed: isButtonEnabled
                  ? () {
                      onSubmit();
                    }
                  : null,
              child: Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          child: SafeArea(
            child: CupertinoListSection(
              header: Text('You can change your available username.'),
              children: [
                BlocProvider(
                  create: (_) => IsUsernameAvailableBloc(
                    CheckIsUsernameAvailable(
                      ProfileRepositoryImpl(
                        ProfileRemoteDataSource(dioClient.dio),
                      ),
                    ),
                  ),
                  child:
                      BlocConsumer<
                        IsUsernameAvailableBloc,
                        IsUsernameAvailableState
                      >(
                        builder: (context, state) {
                          Widget checkWidget = Icon(
                            CupertinoIcons.check_mark_circled,
                            color: CupertinoColors.tertiaryLabel.resolveFrom(
                              context,
                            ),
                          );
                          if (state is IsUsernameAvailableLoading) {
                            // setState(() {
                            checkWidget = Center(
                              child: CupertinoActivityIndicator(),
                            );
                            // });
                          }
                          if (state is IsUsernameAvailableSuccess) {
                            isAvailable =
                                state.isUsernameAvailableModel.isAvailable &&
                                _controller.text.length > 3;

                            //     &&
                            //     widget.username != _controller.text
                            // ? true
                            // : false;

                            if (isAvailable) {
                              checkWidget = Icon(
                                CupertinoIcons.check_mark_circled,
                                color: CupertinoColors.activeGreen.resolveFrom(
                                  context,
                                ),
                              );
                            } else {
                              checkWidget = Icon(
                                CupertinoIcons.check_mark_circled,
                                color: CupertinoColors.tertiaryLabel
                                    .resolveFrom(context),
                              );
                            }

                            context.watch<UpdateProfileBloc>().add(
                              UpdateProfileChanged(_controller.text),
                            );
                            checkButtonEnabled();
                            // isButtonEnabled = isAvailable;
                          }

                          return CupertinoTextField(
                            placeholder: 'username',
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            inputFormatters: [allowedCharacter],
                            suffix: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: checkWidget,
                            ),

                            controller: _controller,

                            onChanged: (value) {
                              // context.read<UpdateProfileBloc>().add(
                              //   UpdateProfileChanged(value),
                              // );

                              if (value.length > 3) {
                                context.read<IsUsernameAvailableBloc>().add(
                                  IsUsernameAvailableSubmitted(value),
                                );
                                // checkAvailability(value.trim());
                              }

                              // checkButtonEnabled();
                            },
                          );
                        },
                        listener:
                            (
                              BuildContext context,
                              IsUsernameAvailableState state,
                            ) {
                              if (state is IsUsernameAvailableFailure) {
                                ErrorPopup.show(
                                  context,
                                  'Something went wrong with username',
                                );
                              }
                            },
                      ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, UpdateProfileState state) {
        if (state is UpdateProfileSuccess) {
          Navigator.pop(context, true);
        }
        if (state is UpdateProfileFailure) {
          ErrorPopup.show(context, state.message);
        }
      },
    );
  }
}
