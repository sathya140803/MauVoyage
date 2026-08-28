import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_application/ui/settings/theme_provider.dart';
import '../../acc_management/authentications.dart';
import '../settings/AboutPage.dart';
import '../settings/NotificationSettingsPage.dart';
import '../settings/ProfileSettingsPage.dart';
import '../settings/SecuritySettingsPage.dart';
import '../settings/LanguageSettingsPage.dart';
import '../../acc_management/logout_notice.dart';
import 'FontSizeSettingsPage.dart';
import 'font_provider.dart';


import 'package:my_application/Applocalizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),

      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.grey[200],  // Conditional background color
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 30, // Made it slightly bigger
                backgroundImage: NetworkImage(AuthService().getCurrentUser()?.photoURL?? 'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg'),
                // Or use AssetImage for local images:
                // backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 8.0), // Space between picture and username
              // Username
              Text(
                '${AuthService().getCurrentUser()?.displayName}',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0), // Space between username and email
              const SizedBox(height: 4.0), // Space between username and email
              // Email
              Text(
                AuthService().getCurrentUser()?.email ?? 'No email available',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const Divider(height: 32.0),




          // Account Management Section
          _buildSectionTitle('Account Management'),
          _buildListTile(
            title: 'Profile',
            subtitle: 'Manage your profile settings',
            icon: MaterialCommunityIcons.account,
            iconColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              ).then((val){setState(() {});});
            },
          ),_buildListTile(
            title: 'Security',
            subtitle: 'Change your password and security settings',
            icon: MaterialCommunityIcons.lock,
            iconColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
              );
            },
          ),
          const Divider(height: 32.0),

          // General Section
          _buildSectionTitle('General'),
          _buildListTile(
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            icon: MaterialCommunityIcons.bell,
            iconColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
              );
            },
          ),
          _buildListTile(
            title: 'Language',
            subtitle: 'Change your app language',
            icon: MaterialCommunityIcons.translate,
            iconColor: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageSettingsPage()),
              );
            },
          ),
          const Divider(height: 32.0),

          _buildSectionTitle('Appearance'),
          _buildSwitchTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark mode for better night-time use.',
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(value),
            icon: MaterialCommunityIcons.theme_light_dark,
          ),
          _buildSwitchTile(
            title: 'Emergency Button',
            subtitle: 'Enable the emergency button to appear on the root page.',

            value: themeProvider.isEmergencyButtonEnabled,
            onChanged: (value) {
              themeProvider.toggleEmergencyButton(value);
            },
            icon: Feather.alert_circle,
          ),
          const Divider(height: 32.0),
          _buildSectionTitle('Accessibility'),
          _buildListTile(
            title: 'Font Size',
            subtitle: 'Adjust text size for better readability',
            icon: Icons.format_size,
            iconColor: Colors.blueGrey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FontSizeSettingsPage()),
              );
            },
          ),
          _buildListTile(
            title: 'Accessibility Settings',
            subtitle: 'Open accessibility settings on your device',
            icon: Icons.accessibility,
            iconColor: Colors.deepPurple,
            onTap: () {
              AppSettings.openAppSettings(type: AppSettingsType.accessibility);
            },
          ),


          const Divider(height: 32.0),



          // About Section
          _buildSectionTitle('About'),
          _buildListTile(
            title: 'About App',
            subtitle: 'Information about this app',
            icon: MaterialCommunityIcons.information,
            iconColor: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),

          const Divider(height: 32.0),


          _buildListTile(
            title: 'Log Out',
            subtitle: 'Log out from this app',
            icon: MaterialCommunityIcons.logout,
            iconColor: Colors.redAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutDialog(onLogoutPressed: () {  },)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      elevation: 2,
      child: ListTile(
        leading: _buildIconWithCircle(icon, iconColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildIconWithCircle(IconData icon, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.0,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: value ? Colors.white : Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

