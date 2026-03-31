import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:college_project/core/utils/prefix_formatter.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/community/data/datasources/community_remote_data_source.dart';
import 'package:college_project/features/community/data/repoitories/community_repository_impl.dart';
import 'package:college_project/features/community/domain/usecase/check_community_name_availability.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_bloc.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_event.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_state.dart';
import 'package:college_project/features/community/presentation/bloc/is_community_name_available_bloc/is_community_name_available_bloc.dart';
import 'package:college_project/features/community/presentation/bloc/is_community_name_available_bloc/is_community_name_available_event.dart';
import 'package:college_project/features/community/presentation/bloc/is_community_name_available_bloc/is_community_name_available_state.dart';
import 'package:college_project/features/posts/presentation/pages/create_new_post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityDetailsPage extends StatefulWidget {
  final CommunityTopic topic;
  final CommunitySharedValue sharedValue;
  final CommunityType communityType;

  const CommunityDetailsPage({
    super.key,
    required this.topic,
    required this.sharedValue,
    required this.communityType,
  });

  @override
  State<CommunityDetailsPage> createState() => _CommunityDetailsPageState();
}

class _CommunityDetailsPageState extends State<CommunityDetailsPage> {
  final SecureStorageService storageService = SecureStorageService();
  late final DioClient dioClient = DioClient(storageService);

  final allowedCharacter = FilteringTextInputFormatter.allow(
    RegExp(r'^[c/]*[a-zA-Z0-9_.]*'),
  );
  final TextEditingController displayNameTextController =
      TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  bool isNameAvail = false;
  bool isButtonEnabled = false;

  int nameCount = 0;
  int nameIdCount = 0;
  int detailCount = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    detailsController.dispose();
  }

  void onSubmit() {
    context.read<CreateCommunityBloc>().add(
      CreateCommunitySubmitted(
        topic: widget.topic.name,
        sharedValue: widget.sharedValue.name,
        communityType: widget.communityType.name,
        communityName: nameTextController.text.substring(2).trim(),
        description: detailsController.text.trim(),
        displayName: displayNameTextController.text.trim(),
      ),
    );
  }

  void onReload(String? value) {
    context.watch<CreateCommunityBloc>().add(CreateCommunityChanged(value));
  }

  void buttonEnable() {
    final result =
        isNameAvail &&
            displayNameTextController.text.trim().length > 2 &&
            detailsController.text.trim().length > 15
        ? true
        : false;

    // setState(() {
    isButtonEnabled = result;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCommunityBloc, CreateCommunityState>(
      builder: (context, state) {
        if (state is CreateCommunityLoading) {
          return Center(child: CupertinoActivityIndicator());
        }

        if (state is CreateCommunitySuccess) {
          // Navigate to next screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamedAndRemoveUntil(
              '/community-page',
              (route) => route.isFirst,
              arguments: {
                'communityId': state.communityIdAndNameModel.communityId,
                'communityName': state.communityIdAndNameModel.communityName,
              },
            );
          });
        }

        // context.watch<CreateCommunityBloc>().add(CreateCommunityChanged(''));
        // context.watch<CreateCommunityBloc>().add(
        //   CreateCommunityChanged(value),
        // );

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Type',
            middle: Text('Community Details'),
            trailing: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: isButtonEnabled
                  ? () {
                onSubmit();
              }
                  : null,
              child: Text('Create', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                CupertinoListSection(
                  topMargin: 8,
                  header: Text(
                    'Choose the community Name. This will show as Display Name.',
                  ),
                  children: [
                    CupertinoTextField.borderless(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      placeholder: 'Community Display Name',
                      suffix: Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text(
                          '$nameCount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      maxLength: 25,
                      controller: displayNameTextController,
                      onChanged: (value) {
                        nameCount = value.length;

                        // onReload(value);

                        // buttonEnable();
                      },
                    ),
                  ],
                ),

                BlocProvider(
                  create: (_) => IsCommunityNameAvailableBloc(
                    CheckCommunityNameAvailability(
                      CommunityRepositoryImpl(
                        CommunityRemoteDataSource(dioClient.dio),
                      ),
                    ),
                  ),
                  child:
                      BlocConsumer<
                        IsCommunityNameAvailableBloc,
                        IsCommunityNameAvailableState
                      >(
                        builder: (context, state) {
                          Widget checkWidget = Icon(
                            CupertinoIcons.exclamationmark_circle,
                            color: CupertinoColors.destructiveRed.resolveFrom(
                              context,
                            ),
                          );
                          if (state is IsCommunityNameFailure) {
                            checkWidget = Icon(
                              CupertinoIcons.exclamationmark_circle,
                              color: CupertinoColors.destructiveRed.resolveFrom(
                                context,
                              ),
                            );
                          }
                          if (state is IsCommunityNameLoading) {
                            // setState(() {
                            checkWidget = Center(
                              child: CupertinoActivityIndicator(),
                            );
                            // });
                          }
                          if (state is IsCommunityNameSuccess) {
                            isNameAvail =
                                state.availableModel.isAvailable &&
                                nameTextController.text.length > 5 &&
                                nameTextController.text.length <= 21;

                            if (isNameAvail) {
                              checkWidget = Icon(
                                CupertinoIcons.check_mark_circled,
                                color: CupertinoColors.activeGreen.resolveFrom(
                                  context,
                                ),
                              );
                            } else {
                              checkWidget = Icon(
                                CupertinoIcons.exclamationmark_circle,
                                color: CupertinoColors.destructiveRed
                                    .resolveFrom(context),
                              );
                            }

                            // context.watch<UpdateProfileBloc>().add(
                            //   UpdateProfileChanged(_controller.text),
                            // );
                            // checkButtonEnabled();
                            // setState(() {
                              isButtonEnabled = isNameAvail;
                            // });
                          }

                          context.watch<CreateCommunityBloc>().add(
                            CreateCommunityChanged(''),
                          );
                          buttonEnable();

                          return CupertinoListSection(
                            topMargin: 8,
                            header: Text(
                              'Choose the community username. Anyone can see and search with this name.',
                            ),
                            children: [
                              CupertinoTextField.borderless(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                placeholder: 'Community Name',

                                suffix: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    spacing: 4,
                                    children: [
                                      checkWidget,
                                      Text(
                                        '$nameIdCount',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller: nameTextController,
                                inputFormatters: [
                                  PrefixFormatter(prefix: 'c/'),
                                  allowedCharacter,
                                ],
                                onChanged: (value) {
                                  nameIdCount = value.isEmpty
                                      ? 0
                                      : value.substring(2).length;

                                  // for updating the screen
                                  // context.watch<CreateCommunityBloc>().add(
                                  //   CreateCommunityChanged(value),
                                  // );

                                  if (value.length > 5) {
                                    context
                                        .read<IsCommunityNameAvailableBloc>()
                                        .add(
                                          IsCommunityNameSubmitted(
                                            value.substring(2).toString(),
                                          ),
                                        );

                                    // buttonEnable();
                                    // checkAvailability(value.trim());
                                  } else {
                                    setState(() {
                                      checkWidget = Icon(
                                        CupertinoIcons.exclamationmark_circle,
                                        color: CupertinoColors.destructiveRed
                                            .resolveFrom(context),
                                      );
                                    });
                                    // buttonEnable();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                        listener:
                            (
                              BuildContext context,
                              IsCommunityNameAvailableState state,
                            ) {
                              if (state is IsCommunityNameFailure) {
                                ErrorPopup.show(
                                  context,
                                  state.message,
                                  // 'Something went wrong with community name',
                                );
                              }
                            },
                      ),
                ),

                Expanded(
                  flex: 1,
                  child: CupertinoListSection(
                    header: Text('Write some community Details'),
                    topMargin: 4,
                    children: [
                      CupertinoTextField.borderless(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        placeholder: 'Community Details',
                        suffix: Padding(
                          padding: EdgeInsetsGeometry.all(8.0),
                          child: Text(
                            '$detailCount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        controller: detailsController,
                        minLines: 5,
                        maxLines: 7,
                        maxLength: 150,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          detailCount = value.length;

                          // for updating the screen
                          // context.watch<CreateCommunityBloc>().add(
                          //   CreateCommunityChanged(value),
                          // );

                          buttonEnable();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, CreateCommunityState state) {
        if (state is CreateCommunityFailure) {
          ErrorPopup.show(context, state.message);
        }
      },
    );
  }
}
