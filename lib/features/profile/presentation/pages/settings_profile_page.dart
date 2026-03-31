import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:flutter/cupertino.dart';

class SettingsProfilePage extends StatefulWidget {
  final String username;

  const SettingsProfilePage({super.key, required this.username});

  @override
  State<SettingsProfilePage> createState() => _SettingsProfilePageState();
}

class _SettingsProfilePageState extends State<SettingsProfilePage> {
  void clearStorage() async {
    await SecureStorageService().clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Profile',
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection(
              hasLeading: false,
              children: [
                CupertinoListTile.notched(
                  title: Text('Change Password'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/change-password',
                        (route) => true,
                        arguments: widget.username,
                      );
                    });
                  },
                ),
                CupertinoListTile.notched(
                  title: Text('Privacy Policy'),
                  onTap: () {},
                ),
              ],
            ),

            CupertinoListSection(
              hasLeading: false,
              topMargin: 0,
              header: Text('DESTRUCTIVE'),
              children: [
                CupertinoListTile.notched(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    clearStorage();
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushReplacementNamed('/login');
                  },
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: CupertinoButton(
                //     // color: CupertinoColors.destructiveRed,
                //     child: Text(
                //       'Logout',
                //       style: TextStyle(
                //         color: CupertinoColors.destructiveRed,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
