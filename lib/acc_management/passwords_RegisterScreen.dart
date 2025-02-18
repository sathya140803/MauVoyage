import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_application/acc_management/name_RegisterScreen.dart';
import '../ui/InterestSelectionScreen.dart';
import 'authentications.dart';

class PasswordSignUpPage extends StatefulWidget {
  final String email; // Define the email as a field in the constructor

  const PasswordSignUpPage({super.key, required this.email});

  @override
  PasswordSignUpPageState createState() => PasswordSignUpPageState();
}

class PasswordSignUpPageState extends State<PasswordSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isRememberMeChecked = false;
  final AuthService _authService = AuthService();

  Future<void> checkEmailVerification() async {
    bool isEmailVerified = false;
    User? user = _authService.getCurrentUser();

    while (!isEmailVerified) {
      await Future.delayed(Duration(seconds: 3));
      await user?.reload();
      user = _authService.getCurrentUser();
      isEmailVerified = user?.emailVerified ?? false;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Email verified successfully!"),
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InterestSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: MediaQuery.of(context).viewInsets.bottom == 0
              ? NeverScrollableScrollPhysics()
              : null,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 290,  // Reduced from 350
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/acc_management/bali.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 36,  // Reduced from 42
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),  // Reduced from 10
                      Text(
                        "Your Next Adventure Starts Here!",
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 16,  // Reduced from 18
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        const SizedBox(height: 12),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.cyan,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 2,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.cyan,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),  // Reduced from 16

                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.cyan,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 2,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.cyan,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 1),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _isRememberMeChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isRememberMeChecked = value ?? false;
                                    });
                                  },
                                  activeColor: Colors.cyan,
                                ),
                                Text(
                                  "Remember me",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14, // Reduced font size
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              try {
                                await _authService.RegisterPassword(
                                    _passwordController.text.trim(), _isRememberMeChecked);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NameSignUpPage(email: widget.email),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                    duration: const Duration(seconds: 5),
                                  ),
                                );
                              }
                            }
                          },

                          child: SizedBox(
                            width: 155,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.cyan,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Text(
                                  "Next",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}