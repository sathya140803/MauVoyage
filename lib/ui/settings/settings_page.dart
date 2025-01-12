import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(106.0), // Height of app bar
        child: AppBar(
          backgroundColor: Colors.transparent, // Make background transparent
          elevation: 0, // Remove shadow for a flat look
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Padding at the bottom
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70.0), // Space above title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0), // Space between title and search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search settings...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Reduce height
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200], // Set background color to a light grey
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
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
                MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
              );
            },
          ),
          _buildListTile(
            title: 'Security',
            subtitle: 'Change your password and security settings',
            icon: MaterialCommunityIcons.lock,
            iconColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecuritySettingsPage()),
              );
            },
          ),
          const Divider(height: 32.0),

          // Dark Mode Toggle Section
          _buildSectionTitle('Appearance'),
          _buildSwitchTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark mode for better night-time use.',
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            icon: MaterialCommunityIcons.theme_light_dark,
          ),
          const SizedBox(height: 16.0),

          // General Settings Section
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
          _buildListTile(
            title: 'Personalized Features',
            subtitle: 'Change your app preferences',
            icon: MaterialCommunityIcons.pretzel,
            iconColor: Colors.teal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageSettingsPage()),
              );
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
        trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54),
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
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.0, // Adjust size if necessary
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
        leading: Icon(icon, color: _isDarkMode ? Colors.white : Colors.blue),
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

// Placeholder pages for navigation
class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Center(child: const Text('Profile Settings Page')),
    );
  }
}

class SecuritySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Settings')),
      body: Center(child: const Text('Security Settings Page')),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: Center(child: const Text('Notification Settings Page')),
    );
  }
}

class LanguageSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language Settings')),
      body: Center(child: const Text('Language Settings Page')),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(child: const Text('About Page')),
    );
  }
}