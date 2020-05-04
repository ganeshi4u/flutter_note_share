import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:note_share/utils/auth.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback logoutCallback;

  SettingsPage({this.logoutCallback});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(sections: [
        SettingsSection(
          title: 'Profile',
          tiles: [
            SettingsTile(
              title: 'Logout',
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                signOutUser();
                widget.logoutCallback();
                Navigator.pop(context);
              },
            ),
          ],
        )
      ]),
    );
  }
}
