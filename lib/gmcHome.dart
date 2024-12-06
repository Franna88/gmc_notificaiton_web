import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/linesMain.dart';
import 'package:gmcweb/Navbar/navBarMain.dart';
import 'package:gmcweb/Reports/reportsMain.dart';
import 'package:gmcweb/Users/usersMain.dart';

class GmcHome extends StatefulWidget {
  const GmcHome({super.key});

  @override
  State<GmcHome> createState() => _GmcHomeState();
}

class _GmcHomeState extends State<GmcHome> {
  var pageIndex = 0;
  User? _currentUser;

  // List of pages
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();

    // Initialize pages with user details if needed
    pages = [
      LinesMain(user: _currentUser),
      UsersMain(user: _currentUser),
      ReportsMain(user: _currentUser),
    ];
  }

  // Fetch current logged-in user
  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  void changePage(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'Welcome, ${_currentUser?.email ?? "User"}',
      //     style: const TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.blueGrey,
      // ),
      body: Row(
        children: [
          NavBarMain(
            changePage: changePage,
          ),
          SizedBox(
            width: MyUtility(context).width - 280,
            height: MyUtility(context).height,
            child: Center(child: pages[pageIndex]),
          ),
        ],
      ),
    );
  }
}
