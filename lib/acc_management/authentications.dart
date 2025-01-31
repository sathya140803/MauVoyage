import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Returning the User object
    } on FirebaseAuthException catch (e) {
      print("Error signing in with email and password: $e");
      return null; // Return null on error (login failed)
    }
  }



  // Register a new user and send email verification
  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        // Send email verification
        await user.sendEmailVerification();

        return "A verification email has been sent to $email. Please verify your email to complete the registration.";
      }
      return "User registration failed.";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use by another account.');
      } else if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else {
        throw Exception(e.message ?? 'Registration failed.');
      }
    }
  }




  // Forgot Password Method
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Password reset email has been sent!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else {
        return e.message ?? 'Failed to send password reset email.';
      }
    }
  }



  // Logout Method
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Check if user is logged in
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

