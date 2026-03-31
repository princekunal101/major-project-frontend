import 'package:college_project/core/constants/month_names.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_bloc.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_state.dart';
import 'package:college_project/features/auth/presentation/components/already_have_account_button.dart';
import 'package:college_project/features/auth/presentation/widgets/error_popup.dart';
import 'package:college_project/features/auth/presentation/widgets/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetDobPage extends StatefulWidget {
  final String userId;

  const SetDobPage({super.key, required this.userId});

  @override
  State<SetDobPage> createState() => _SetDobPageState();
}

class _SetDobPageState extends State<SetDobPage> {
  DateTime now = DateTime.now();
  late final DateTime maxDate = DateTime(now.year - 13, now.month, now.day);
  final int minYear = DateTime.now().year - 120;
  late DateTime setDate = DateTime(2004, 15, 4);

  void _onSubmit() {

    context.read<SetDobBloc>().add(
      SetDobEventSubmitted(widget.userId, setDate.toIso8601String().split('T').first),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('What\'s your date of birth'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: BlocConsumer<SetDobBloc, SetDobState>(
            builder: (context, state) {
              if (state is SetDobLoading) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (state is SetDobSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/set-name',
                    (route) => true,
                    arguments: widget.userId,
                  );
                });
              }
              return Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Use your own date of birth, even if this account is for a business, a pet or something else. No one will see this unless you choose to share it.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.tinted(
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
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      sizeStyle: CupertinoButtonSize.medium,
                      child: Text('Next'),
                      onPressed: () {
                        _onSubmit();
                      },
                    ),
                  ),
                  Spacer(),

                  AlreadyHaveAccountButton(),

                  // SizedBox(
                  //   height: 316,
                  //   child: CupertinoDatePicker(
                  //     initialDateTime: setDate,
                  //     mode: CupertinoDatePickerMode.date,
                  //     onDateTimeChanged: (DateTime newDate) {
                  //       setState(() {
                  //         setDate = newDate;
                  //       });
                  //     },
                  //     minimumYear: minYear,
                  //     maximumYear: maxYear,
                  //   ),
                  // ),
                ],
              );
            },
            listener: (BuildContext context, SetDobState state) {
              if (state is SetDobFailure) {
                ErrorPopup.show(context, state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}
