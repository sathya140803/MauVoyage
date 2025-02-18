import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/InterestSelectionScreen.dart';
import 'login_page.dart';
import 'authentications.dart';
import 'passwords_RegisterScreen.dart';

class EmailSignUpPage extends StatefulWidget {
  const EmailSignUpPage({super.key});

  @override
  EmailSignUpPageState createState() => EmailSignUpPageState();
}

class EmailSignUpPageState extends State<EmailSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> checkEmailVerification() async {
    User? user = _authService.getCurrentUser();
    bool isEmailVerified = user?.emailVerified ?? false;

    // Check if the email is verified or not.
    while (!isEmailVerified) {
      await Future.delayed(Duration(seconds: 3)); // Delay before checking again
      await user?.reload();  // Reload the user info
      user = _authService.getCurrentUser();
      isEmailVerified = user?.emailVerified ?? false;

      // If verification takes longer than 60 seconds, show a message and return
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Unable to verify email.")),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Email verified successfully!")),
    );

    // Navigate to the next page (PasswordSignUpPage)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordSignUpPage(email: user!.email!),
      ),
    );
  }

  Future<void> _registerAndVerifyEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Register the user with the email
        User? user = await _authService.RegisterEmail(_emailController.text.trim());

        if (user != null) {
          // Notify the user that the email verification has been sent
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification email sent. Please verify your email.")),
          );

          // Show a dialog telling the user to verify the email
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Verify Your Email"),
                content: Text(
                  "A verification email has been sent to your email address. "
                      "Please verify your email and return to the app.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      checkEmailVerification(); // Call the email verification function
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), duration: Duration(seconds: 5)),
        );
      }
    }
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
                  height: 290,
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
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Your Next Adventure Starts Here!",
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 16,
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: GoogleFonts.roboto(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.cyan, width: 2),
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.cyan),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            _registerAndVerifyEmail(); // Register and verify email flow
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

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignInPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: "Sign In",
                                    style: GoogleFonts.roboto(
                                      color: Colors.cyan,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
