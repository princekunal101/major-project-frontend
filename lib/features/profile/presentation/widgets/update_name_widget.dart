import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNameWidget extends StatefulWidget {
  final String name;

  const UpdateNameWidget({super.key, required this.name});

  @override
  State<UpdateNameWidget> createState() => _UpdateNameWidgetState();
}

class _UpdateNameWidgetState extends State<UpdateNameWidget> {
  final TextEditingController controller = TextEditingController();
  late bool isButtonEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.name;
  }

  // void onValueChange(String name) {
  //   if (name.trim() != widget.name) {
  //     setState(() {
  //       isButtonEnabled = true;
  //     });
  //   } else {
  //     setState(() {
  //       isButtonEnabled = false;
  //     });
  //   }
  // }

  void onSubmit() {
    context.read<UpdateProfileBloc>().add(
      UpdateProfileSubmitted(fullName: controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        // if (controller.text.trim() != widget.name) {
        //   isButtonEnabled = true;
        // } else {
        //   isButtonEnabled = false;
        // }
        if (state is UpdateProfileLoading) {
          return Center(child: CupertinoActivityIndicator());
        }

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Edit Profile',
            middle: Text('Update Name'),
            trailing: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: controller.text.trim() != widget.name
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
              header: Text(
                'You can change your profile name after the editing.',
              ),
              children: [
                CupertinoTextField(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  placeholder: 'Name',
                  controller: controller,
                  onChanged: (value) {
                    context.read<UpdateProfileBloc>().add(
                      UpdateProfileChanged(value),
                    );
                    // if (value.trim() != widget.name) {
                    //   isButtonEnabled = true;
                    //   setState(() {});
                    // } else {
                    //   isButtonEnabled = false;
                    //   setState(() {});
                    // }
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, UpdateProfileState state) {
        // if (controller.text.trim() != widget.name) {
        //   isButtonEnabled = true;
        // } else {
        //   isButtonEnabled = false;
        // }
        if (state is UpdateProfileSuccess) {
          // Future.microtask(() {
          Navigator.pop(context, true);
          // });
        }
        if (state is UpdateProfileFailure) {
          ErrorPopup.show(context, state.message);
        }
      },
    );
  }
}
