import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/content/cloudinary_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../acc_management/authentications.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isEditing = false;


  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _authService.getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Get local storage
    setState(() {
      _usernameController.text = user?.displayName ?? 'No name available';
      _emailController.text = user?.email ?? 'No email available';
      _phoneController.text = prefs.getString('phoneNumber') ?? 'No phone Number'; // Get stored phone number
    });
  }




  void _saveProfile() async {
    try {
      String newUsername = _usernameController.text;
      String newEmail = _emailController.text;
      String newPhone = _phoneController.text;

      if (newUsername.isNotEmpty) {
        await _authService.updateDisplayName(newUsername);
      }
      if (newEmail.isNotEmpty) {
        // Prompt the user for their current password
        String? currentPassword = await _getCurrentPasswordFromUser(context);
        if (currentPassword == null || currentPassword.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password is required to update email.")),
          );
          return;
        }

        // Update the email
        await _authService.updateEmail(
          newEmail: newEmail,
          currentPassword: currentPassword,
        );
      }
      await _loadUserData();



      // Save phone number locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneNumber', newPhone);

      _loadUserData(); // Refresh UI with updated details
      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!")),
      );
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile")),
      );
    }
  }


  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var path = pickedFile.path;
      File img = File(path);
      var response = await uploadImage(img);
      String? newUrl = response?.data?.url;
      if(newUrl != null){
        await _authService.updatePhotoURL(newUrl);
      }
      setState(() {

      });
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  void _enableEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _profileImageUrl = AuthService().getCurrentUser()?.photoURL?? 'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg';
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          // Profile Image and Username
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(_profileImageUrl),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: _pickImage, // When clicked, pick a new image
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Display the Username directly below the profile picture
                Text(
                  _usernameController.text, // Use the username controller to display it
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    readOnly: !_isEditing, // If not editing, make the field read-only
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    readOnly: !_isEditing, // If not editing, make the field read-only
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    readOnly: !_isEditing, // If not editing, make the field read-only
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _isEditing
              ? Column(
            children: [
              // Save Profile button with a fixed width
              Container(
                width: 250, // Set a fixed width for the button
                child: ElevatedButton(
                  onPressed: _saveProfile, // Save profile changes
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Save button should be green
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Save Profile',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Cancel button with the same fixed width
              Container(
                width: 250, // Set the same width as the Save button
                child: ElevatedButton(
                  onPressed: _cancelEditing, // Cancel editing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),
              ),
            ],
          )
              : Container(
            width: 250, // Set the width for the Edit button
            child: ElevatedButton(
              onPressed: _enableEditing, // Enable editing when the "Edit" button is pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<String?> _getCurrentPasswordFromUser(BuildContext context) async {
    String? currentPassword;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Re-authenticate"),
          content: TextField(
            obscureText: true, // Hide password input
            decoration: InputDecoration(
              labelText: "Enter your current password",
            ),
            onChanged: (value) {
              currentPassword = value; // Capture the password
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
    return currentPassword;
  }
}


