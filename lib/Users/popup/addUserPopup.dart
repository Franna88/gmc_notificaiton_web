import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CommonUi/smallButtons.dart';
import '../../Constants/gmcColors.dart';

class AddUserPopup extends StatelessWidget {
  final Function(String name, String email, String password, String role)
      onAddUser;

  const AddUserPopup({required this.onAddUser, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController roleController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true, // Hides the password
          ),
          TextField(
            controller: roleController,
            decoration: const InputDecoration(labelText: 'Role'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onAddUser(
                nameController.text.trim(),
                emailController.text.trim(),
                passwordController.text.trim(),
                roleController.text.trim(),
              );
            },
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}
