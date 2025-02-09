import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Users/UserTable/userTable.dart';
import 'package:gmcweb/Users/popup/addUserPopup.dart';

import '../Constants/gmcColors.dart';

class UsersMain extends StatefulWidget {
  final User? user;
  const UsersMain({super.key, required this.user});

  @override
  State<UsersMain> createState() => _UsersMainState();
}

class _UsersMainState extends State<UsersMain> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> _users = [];
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    if (_isDisposed) return;

    try {
      final querySnapshot = await _firestore.collection('users').get();
      if (_isDisposed) return;

      final fetchedUsers = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'name': data['name'] as String? ?? '',
          'email': data['email'] as String? ?? '',
          'role': data['role'] as String? ?? '',
        };
      }).toList();

      if (mounted && !_isDisposed) {
        setState(() {
          _users = fetchedUsers;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _addUserToFirebase(
      String name, String email, String role) async {
    if (_isDisposed) return;

    try {
      // Add user to Firestore
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'role': role,
      });

      // Only refresh if not disposed
      if (!_isDisposed) {
        await _fetchUsers();
      }
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<void> _addUser(
      String name, String email, String contactNo, String role) async {
    await _addUserToFirebase(name, email, role);
    Navigator.pop(context); // Close the popup after adding
  }

  Future openAddUserPopup() => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: AddUserPopup(onAddUser: _addUser),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const StackedHeaders(
                  constrianedWidth: 450, width: 445, header: 'Users'),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: SmallButtons(
                  onTap: openAddUserPopup,
                  buttonText: 'Add User',
                  buttonColor: GmcColors().teal,
                ),
              ),
              const SizedBox(height: 25),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : UserTable(users: _users),
            ],
          ),
        ),
      ),
    );
  }
}
