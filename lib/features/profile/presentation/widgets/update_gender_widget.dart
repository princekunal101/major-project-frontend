import 'package:college_project/core/utils/enums/gender_enum.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateGenderWidget extends StatefulWidget {
  final String gender;

  const UpdateGenderWidget({super.key, required this.gender});

  @override
  State<UpdateGenderWidget> createState() => _UpdateGenderWidgetState();
}

class _UpdateGenderWidgetState extends State<UpdateGenderWidget> {
  GenderEnum _enum = GenderEnum.female;
  bool isButtonEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEnumValue();
  }

  void setEnumValue() {
    if (widget.gender.isNotEmpty) {
      _enum = GenderEnum.values.byName(widget.gender);
    } else {
      setState(() {
        isButtonEnable = true;
      });
    }
  }

  void checkIsButtonEnable() {
    if (widget.gender.isNotEmpty) {
      setState(() {
        isButtonEnable = _enum == GenderEnum.values.byName(widget.gender)
            ? false
            : true;
      });
    } else {
      isButtonEnable = true;
    }
  }

  void onSubmit() {
    context.read<UpdateProfileBloc>().add(
      UpdateProfileSubmitted(null, null, _enum.name, null, null, null, null),
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
            middle: Text('Choose gender'),
            trailing: CupertinoButton(
              padding: EdgeInsets.all(0),
              onPressed: isButtonEnable
                  ? () {
                      onSubmit();
                    }:null,
              child: Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          child: SafeArea(
            child: RadioGroup(
              groupValue: _enum,
              onChanged: (GenderEnum? value) {
                setState(() {
                  _enum = value!;
                });
                checkIsButtonEnable();
              },
              child: CupertinoListSection(
                header: Text('Choose gender from the following list'),
                children: [
                  CupertinoListTile(
                    title: Text('Female'),
                    leading: CupertinoRadio(value: GenderEnum.female),
                  ),
                  CupertinoListTile(
                    title: Text('Male'),
                    leading: CupertinoRadio(value: GenderEnum.male),
                  ),
                  CupertinoListTile(
                    title: Text('Others'),
                    leading: CupertinoRadio(value: GenderEnum.others),
                  ),
                ],
              ),
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
