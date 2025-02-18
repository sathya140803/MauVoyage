import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:my_application/notification_schedule/local_notification.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password, bool rem) async {
    _auth.signOut();
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(rem){
        var userDetails = {
          "email": email,
          "password": password,
        };
        GetStorage().write("userDetails", jsonEncode(userDetails));
      }
      return userCredential.user; // Returning the User object
    } on FirebaseAuthException catch (e) {
      print("Error signing in with email and password: $e");
      return null; // Return null on error (login failed)
    }
  }






  Future<User?> RegisterEmail(String email) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: "aaaaa1", // Temporary password, actual password will be updated later
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification(); // Send verification email
      }

      var userDetails = {
        "email": email,
        "password": "aaaaa1",
      };
      GetStorage().write("userDetails", jsonEncode(userDetails));

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use by another account.');
      } else {
        throw Exception(e.message ?? 'Registration failed.');
      }
    }
  }


  Future<void> RegisterPassword(String password, bool rem) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(password);

        if (rem) {
          var userDetails = {
            "email": user.email,
            "password": password,
          };
          GetStorage().write("userDetails", jsonEncode(userDetails));
        }
      } else {
        throw Exception("No user found. Please restart registration.");
      }
    } catch (e) {
      throw Exception("Failed to update password: ${e.toString()}");
    }
  }




  // Update Display Name
  Future<void> updateDisplayName(String newName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await user.reload(); // Reload user data
      }
    } catch (e) {
      print("Error updating display name: $e");
      throw Exception("Failed to update display name.");
    }
  }


  Future<void> updatePhotoURL(String photoURL) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePhotoURL(photoURL);
        await user.reload(); // Reload user data
      }
    } catch (e) {
      print("Error updating photo URL: $e");
      throw Exception("Failed to update display name.");
    }
  }

  // Update Email
  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No authenticated user.");
      }
      if (user.email == null) {
        throw Exception("User email is null.");
      }

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update email (or use verifyBeforeUpdateEmail)
      await user.verifyBeforeUpdateEmail(newEmail);
      // Sends verification email
      await user.reload();

    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.code} - ${e.message}");
      throw e; // Rethrow to handle in UI
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception("Failed to update email.");
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

  // Change Password Method
  Future<String?> changePassword(String oldPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return 'User not found';
      }

      // Re-authenticate the user before changing password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return 'Password changed successfully';
    } catch (e) {
      return e.toString();
    }
  }

  // Logout Method
  Future<void> logout() async {
    await _auth.signOut();
    LocalNotification.cancelAll();
    GetStorage().remove("userDetails");
    GetStorage().remove("schedules");
    GetStorage().remove("notifications");
    GetStorage().remove("notification_id");
    GetStorage().remove("inAppNotiId");
    GetStorage().remove("favourites");
  }

  // Check if user is logged in
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}