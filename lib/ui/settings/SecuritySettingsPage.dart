import 'package:flutter/material.dart';
import '../../acc_management/authentications.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  String _passwordStrengthMessage = '';
  Color _passwordStrengthColor = Colors.transparent;

  void _checkPasswordStrength(String value) {
    bool hasMinLength = value.length >= 8;
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasNumber = value.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    bool isStrong = hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar;

    setState(() {
      if (value.isEmpty) {
        _passwordStrengthMessage = '';
        _passwordStrengthColor = Colors.transparent;
      } else if (isStrong) {
        _passwordStrengthMessage = 'Password strong';
        _passwordStrengthColor = Colors.green;
      } else {
        _passwordStrengthMessage = 'Password too weak';
        _passwordStrengthColor = Colors.red;
      }
    });
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    AuthService authService = AuthService(); // Create an instance
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();

    String? result = await authService.changePassword(oldPassword, newPassword);

    setState(() => _isLoading = false);

    // Show a success or error message based on the result
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              result == 'Password changed successfully'
                  ? Icons.check_circle
                  : Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(result!),
          ],
        ),
        backgroundColor: result == 'Password changed successfully'
            ? Colors.green
            : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (result == 'Password changed successfully') {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.blueGrey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Create a strong and secure password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[300],
                  ),
                ),
                SizedBox(height: 40),

                // Old Password Field
                _buildPasswordField(

                  controller: _oldPasswordController,
                  label: 'Current Password',
                  obscure: _obscureOldPassword,
                  onToggle: () => setState(() => _obscureOldPassword = !_obscureOldPassword),

                ),
                SizedBox(height: 24),

                // New Password Field
                _buildPasswordField(
                  controller: _newPasswordController,
                  label: 'New Password',
                  obscure: _obscureNewPassword,
                  onToggle: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                  onChanged: _checkPasswordStrength,
                ),
                SizedBox(height: 8),

                // Password Strength Message
                if (_passwordStrengthMessage.isNotEmpty)
                  Text(
                    _passwordStrengthMessage,
                    style: TextStyle(
                      color: _passwordStrengthColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                SizedBox(height: 16),

                // Confirm Password Field
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm New Password',
                  obscure: _obscureConfirmPassword,
                  onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                SizedBox(height: 40),

                Column(
                  children: [
                    // Update Password Button
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Update Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Spacing between buttons

                    // Cancel Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blueGrey[200]!),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context), // Close the screen
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your password';
        if (controller == _confirmPasswordController &&
            value != _newPasswordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey[400]),
        floatingLabelStyle: TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey[100]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey[100]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
          color: Colors.blueGrey[400],
        ),

      ),
    );
  }
}