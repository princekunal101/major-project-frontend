import 'package:college_project/core/constants/month_names.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/auth/presentation/widgets/show_dialog.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDobWidget extends StatefulWidget {
  final String dob;

  const UpdateDobWidget({super.key, required this.dob});

  @override
  State<UpdateDobWidget> createState() => _UpdateDobWidgetState();
}

class _UpdateDobWidgetState extends State<UpdateDobWidget> {
  DateTime now = DateTime.now();
  late final DateTime maxDate = DateTime(now.year - 13, now.month, now.day);
  final int minYear = DateTime.now().year - 120;
  late DateTime setDate = DateTime.parse(widget.dob).toLocal();

  bool isButtonEnable = false;

  void onSubmit() {
    context.read<UpdateProfileBloc>().add(
      UpdateProfileSubmitted(dob: setDate.toIso8601String()),
    );
  }

  void checkIsButtonEnabled() {
    setState(() {
      isButtonEnable = DateTime.parse(widget.dob).toLocal() == setDate
          ? false
          : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Edit Profile',
        middle: Text('Edit DoB'),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: isButtonEnable
              ? () {
                  onSubmit();
                }
              : null,
          child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
          if (state is UpdateProfileLoading) {
            return Center(child: CupertinoActivityIndicator());
          }
          return SafeArea(
            child: CupertinoListSection(
              header: Text(
                'Dob can not see other person. You can change your dob, click on time',
              ),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    sizeStyle: CupertinoButtonSize.medium,
                    onPressed: () {
                      ShowDialog.show(
                        context,
                        CupertinoDatePicker(
                          initialDateTime: setDate,
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.dmy,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              setDate = newDate;
                            });
                            checkIsButtonEnabled();
                          },
                          minimumYear: minYear,
                          maximumDate: maxDate,
                        ),
                      );
                    },
                    child: Text(
                      '${setDate.day}-${monthNames[setDate.month - 1]}-${setDate.year}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
