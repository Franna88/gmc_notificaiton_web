import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/CommonUi/logedInUser.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Layout&Nav/Navbar/navBarMain.dart';

import 'package:gmcweb/Lines/linesMain.dart';
import 'package:gmcweb/Reports/reportsMain.dart';
import 'package:gmcweb/Users/usersMain.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({super.key});

  @override
  _MainPageLayoutState createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Lines
    GlobalKey<NavigatorState>(), // Users
    GlobalKey<NavigatorState>(), // Reports
  ];

  void _onTabSelected(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavBarMain(
            initialIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
          ),
          Expanded(
            child: Column(
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
                        userImage: 'images/person.jpg',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      Navigator(
                        key: _navigatorKeys[0],
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (_) => LinesMain(user: currentUser),
                        ),
                      ),
                      Navigator(
                        key: _navigatorKeys[1],
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (_) => UsersMain(user: currentUser),
                        ),
                      ),
                      Navigator(
                        key: _navigatorKeys[2],
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (_) => ReportsMain(user: currentUser),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
