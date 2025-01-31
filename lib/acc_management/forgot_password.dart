import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentications.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for a minimalist look
      appBar: AppBar(
        backgroundColor: Colors.orange,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Password Recovery Label
                Text(
                  "Password Recovery",
                  style: GoogleFonts.roboto(
                    fontSize: 28, // Larger font size for emphasis
                    fontWeight: FontWeight.bold,
                    color: Colors.orange, // Orange color for the label
                  ),
                ),
                const SizedBox(height: 20),

                // Description Text
                Text(
                  "Please enter your email to reset your password.",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email input field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: GoogleFonts.roboto(
                      color: Colors.grey.shade600,
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
                        color: Colors.orange, // Focused border color
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Reset Password button
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String email = _emailController.text;

                      // Call the sendPasswordResetEmail method from AuthService
                      String result = await AuthService().sendPasswordResetEmail(email);

                      // Show the result in a dialog or as a Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

                      // If successful, navigate back or do something else
                      if (result == "Password reset email has been sent!") {
                        Navigator.pop(context); // Go back to the login page or a confirmation screen
                      }
                    }
                  },
                  child: SizedBox(
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          "Reset Password",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Back to Sign In button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Go back to the sign-in page
                  },
                  child: Text(
                    "Back",
                    style: GoogleFonts.roboto(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
