import 'package:college_project/core/constants/month_names.dart';
import 'package:college_project/core/services/dio_client.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/core/widgets/avatar_image_widget.dart';
import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';
import 'package:college_project/features/profile/domain/usecase/update_profile.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_state.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:college_project/features/profile/presentation/widgets/update_bio_widget.dart';
import 'package:college_project/features/profile/presentation/widgets/update_dob_widget.dart';
import 'package:college_project/features/profile/presentation/widgets/update_gender_widget.dart';
import 'package:college_project/features/profile/presentation/widgets/update_name_widget.dart';
import 'package:college_project/features/profile/presentation/widgets/update_username_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserProfilePage extends StatefulWidget {
  final VoidCallback? reload;

  const UpdateUserProfilePage({super.key, this.reload});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  final SecureStorageService storageService = SecureStorageService();
  late final DioClient dioClient = DioClient(storageService);

  String dateString = '';

  void reLoad() {
    context.read<GetProfileBloc>().add(RetryLoadProfile());
    widget.reload?.call();
  }

  void dateStringFormating(String date) {
    final setDate = DateTime.parse(date).toLocal();
    // setState(() {
    dateString =
        '${setDate.day}-${monthNames[setDate.month - 1]}-${setDate.year}';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(
        context,
      ),
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Profile',
        // trailing: CupertinoButton(
        //   padding: EdgeInsets.all(0),
        //   child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      child: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (state is GetProfileLoaded) {
            final userData = state.profileResultModel;
            if (userData.dob != null) {
              dateStringFormating(userData.dob ?? '');
              // final setDate = DateTime.parse(userData.dob ?? '').toLocal();
              // setState(() {
              //   dateString =
              //       '${setDate.day}-${monthNames[setDate.month - 1]}-${setDate.year}';
              // });
            }

            return SafeArea(
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    Column(
                      spacing: 4,
                      children: [
                        AvatarImageWidget(
                          imgUrl: userData.profileImageUrl ?? '',
                        ),
                        Text(
                          userData.name ?? '',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Text(
                        //   'princekunal6521@outlook.com',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     // fontWeight: FontWeight.bold,
                        //     color: CupertinoColors.secondaryLabel.resolveFrom(
                        //       context,
                        //     ),
                        //   ),
                        // ),

                        ?(userData.bio != null && userData.bio!.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  userData.bio ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    // fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context),
                                  ),
                                ),
                              )
                            : null,
                      ],
                    ),
                    CupertinoListSection(
                      // topMargin: 1,
                      hasLeading: false,
                      header: Text(
                        'PROFILE DETAILS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        CupertinoListTile.notched(
                          title: Text('Name'),
                          additionalInfo: Text(userData.name ?? ''),
                          trailing: CupertinoListTileChevron(),
                          onTap: () async {
                            final isUpdated = await showCupertinoModalPopup(
                              context: context,
                              builder: (_) => BlocProvider<UpdateProfileBloc>(
                                create: (_) => UpdateProfileBloc(
                                  UpdateProfile(
                                    ProfileRepositoryImpl(
                                      ProfileRemoteDataSource(dioClient.dio),
                                    ),
                                  ),
                                ),
                                child: UpdateNameWidget(
                                  name: userData.name ?? '',
                                ),
                              ),
                            );

                            if (isUpdated != null) {
                              reLoad();
                            }
                          },
                        ),

                        CupertinoListTile.notched(
                          title: Text('Username'),
                          additionalInfo: Text(userData.username ?? ''),
                          trailing: CupertinoListTileChevron(),
                          onTap: () async {
                            final isUpdated = await showCupertinoModalPopup(
                              context: context,
                              builder: (_) => BlocProvider<UpdateProfileBloc>(
                                create: (_) => UpdateProfileBloc(
                                  UpdateProfile(
                                    ProfileRepositoryImpl(
                                      ProfileRemoteDataSource(dioClient.dio),
                                    ),
                                  ),
                                ),
                                child: UpdateUsernameWidget(
                                  username: userData.username ?? '',
                                ),
                              ),
                            );

                            if (isUpdated != null) {
                              reLoad();
                            }
                          },
                        ),

                        // CupertinoListTile.notched(
                        //   title: Text('Pronouns'),
                        //   additionalInfo: Text(userData.pronoun ?? ''),
                        //   trailing: CupertinoListTileChevron(),
                        //   onTap: () {},
                        // ),
                        CupertinoListTile.notched(
                          title: Text('Bio'),
                          additionalInfo: Expanded(
                            child: Text(
                              userData.bio ?? '',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          trailing: CupertinoListTileChevron(),
                          onTap: () async {
                            final isUpdated = await showCupertinoModalPopup(
                              context: context,
                              builder: (_) => BlocProvider<UpdateProfileBloc>(
                                create: (_) => UpdateProfileBloc(
                                  UpdateProfile(
                                    ProfileRepositoryImpl(
                                      ProfileRemoteDataSource(dioClient.dio),
                                    ),
                                  ),
                                ),
                                child: UpdateBioWidget(bio: userData.bio ?? ''),
                              ),
                            );

                            if (isUpdated != null) {
                              reLoad();
                            }
                          },
                        ),

                        // CupertinoListTile.notched(
                        //   title: Text('Link'),
                        //   additionalInfo: Text(userData.link ?? ''),
                        //   trailing: CupertinoListTileChevron(),
                        //   onTap: () {},
                        // ),
                        CupertinoListTile.notched(
                          title: Text('Gender'),
                          additionalInfo: Text(userData.gender ?? ''),
                          trailing: CupertinoListTileChevron(),
                          onTap: () async {
                            final isUpdated = await showCupertinoModalPopup(
                              context: context,
                              builder: (_) => BlocProvider<UpdateProfileBloc>(
                                create: (_) => UpdateProfileBloc(
                                  UpdateProfile(
                                    ProfileRepositoryImpl(
                                      ProfileRemoteDataSource(dioClient.dio),
                                    ),
                                  ),
                                ),
                                child: UpdateGenderWidget(
                                  gender: userData.gender ?? '',
                                ),
                              ),
                            );

                            if (isUpdated != null) {
                              reLoad();
                            }
                          },
                        ),

                        CupertinoListTile.notched(
                          title: Text('Dob'),
                          additionalInfo: Text(dateString),
                          trailing: CupertinoListTileChevron(),
                          onTap: () async {
                            final isUpdated = await showCupertinoModalPopup(
                              context: context,
                              builder: (_) => BlocProvider<UpdateProfileBloc>(
                                create: (_) => UpdateProfileBloc(
                                  UpdateProfile(
                                    ProfileRepositoryImpl(
                                      ProfileRemoteDataSource(dioClient.dio),
                                    ),
                                  ),
                                ),
                                child: UpdateDobWidget(
                                  dob: userData.dob ?? '2004-04-15',
                                ),
                              ),
                            );

                            if (isUpdated != null) {
                              reLoad();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is GetProfileError) {
            return Center(
              child: Column(
                spacing: 8,
                children: [
                  Spacer(),
                  Text('Something went wrong!'),
                  CupertinoButton.filled(
                    sizeStyle: CupertinoButtonSize.medium,
                    child: Text('Retry'),
                    onPressed: () {
                      context.read<GetProfileBloc>().add(RetryLoadProfile());
                    },
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              spacing: 8,
              children: [
                Text('Something went wrong!'),
                CupertinoButton.filled(
                  sizeStyle: CupertinoButtonSize.medium,
                  child: Text('Retry'),
                  onPressed: () {
                    context.read<GetProfileBloc>().add(RetryLoadProfile());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
