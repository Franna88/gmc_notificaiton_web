import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/Antolin_home/antolinMain.dart';
import 'package:gmcweb/CommonUi/logedInUser.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
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
      AntolinMain(),
      //LinesMain(user: _currentUser),
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
      body: Row(
        children: [
          NavBarMain(
            changePage: changePage,
          ),
          Column(
            children: [
              Container(
                height: 65,
                width: MyUtility(context).width - 80,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Image.asset('images/antolinLogo.png'),
                    ),
                    LogedInUser(
                        userName: 'John Smith',
                        userRole: 'Production Manager',
                        userImage: 'images/person.jpg')
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(width: 2, color: GmcColors().antolinBlack),
                    top: BorderSide(width: 2, color: GmcColors().antolinBlack),
                  ),
                ),
                width: MyUtility(context).width - 80,
                height: MyUtility(context).height - 65,
                child: Center(child: pages[pageIndex]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
