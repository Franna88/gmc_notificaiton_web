import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmcweb/Login/login.dart';
import 'package:gmcweb/gmcHome.dart';

class UserState extends StatefulWidget {
  const UserState({super.key});

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (userSnapshot.hasError) {
          // Error state
          return Scaffold(
            body: Center(
              child: Text(
                'An error has occurred: ${userSnapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (userSnapshot.hasData) {
          // User is logged in
          print('User is logged in: ${userSnapshot.data?.email}');
          return const GmcHome();
        }

        // Default: User is not logged in
        print('User is not logged in');
        return const Login();
      },
    );
  }
}
