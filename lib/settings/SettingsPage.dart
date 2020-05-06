import 'package:flutter/material.dart';
import 'package:note_share/utils/providers/AuthProvider.dart';
import 'package:note_share/utils/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  _authProvider.signOutUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Theme',
            tiles: [
              SettingsTile.switchTile(
                title: 'Dark theme',
                leading: Icon(Icons.brightness_4),
                switchValue: Provider.of<ThemeProvider>(context).isDarkModeOn,
                onToggle: (bool value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .updateTheme(value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
