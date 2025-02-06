  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart'; // Add this package to handle image picking

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: ProfileScreen(),
      );
    }
  }

  class ProfileScreen extends StatefulWidget {
    @override
    _ProfileScreenState createState() => _ProfileScreenState();
  }

  class _ProfileScreenState extends State<ProfileScreen> {
    // Controller for form fields
    final TextEditingController _usernameController = TextEditingController(text: 'John Doe');
    final TextEditingController _emailController = TextEditingController(text: 'john.doe@example.com');
    final TextEditingController _phoneController = TextEditingController(text: '+123 456 7890');

    // Profile image URL
    String _profileImageUrl = 'https://www.example.com/profile_pic.jpg';

    // Flag to toggle edit mode
    bool _isEditing = false;

    // Function to pick image from gallery
    Future<void> _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileImageUrl = pickedFile.path; // Update the profile image path
        });
      }
    }

    // Function to save the updated profile information
    void _saveProfile() {
      // Here you can implement logic to save the updated information to your backend or local storage
      print('Updated Username: ${_usernameController.text}');
      print('Updated Email: ${_emailController.text}');
      print('Updated Phone: ${_phoneController.text}');
      print('Updated Profile Image: $_profileImageUrl');
      setState(() {
        _isEditing = false; // After saving, disable editing
      });
    }

    // Function to cancel editing
    void _cancelEditing() {
      setState(() {
        _isEditing = false; // Reset to non-edit mode
      });
    }

    // Function to enable editing
    void _enableEditing() {
      setState(() {
        _isEditing = true;
      });
    }

    @override
    Widget build(BuildContext context) {
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Save Profile',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                  backgroundColor: Colors.blue, // Edit button should be blue
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
