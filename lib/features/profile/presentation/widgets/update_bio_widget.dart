import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBioWidget extends StatefulWidget {
  final String bio;

  const UpdateBioWidget({super.key, required this.bio});

  @override
  State<UpdateBioWidget> createState() => _UpdateBioWidgetState();
}

class _UpdateBioWidgetState extends State<UpdateBioWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.bio.isNotEmpty) {
      _controller.text = widget.bio;
    }
  }

  void onSubmit() {
    context.read<UpdateProfileBloc>().add(
      UpdateProfileSubmitted(
        null,
        null,
        null,
        _controller.text.trim(),
        null,
        null,
        null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        if (state is UpdateProfileLoading) {
          return Center(child: CupertinoActivityIndicator());
        }
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: 'Edit Profile',
            middle: Text('Change your Bio'),
            trailing: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: _controller.text.trim() != widget.bio
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
              header: Text('Change your bio other user can see your bio.'),
              children: [
                CupertinoTextField(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  placeholder: 'Enter your Bio',
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLength: 150,
                  minLines: 2,
                  maxLines: 5,
                  suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${_controller.text.length}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<UpdateProfileBloc>().add(
                      UpdateProfileChanged(value),
                    );
                  },
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
