import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/Antolin_home/antolinMain.dart';
import 'package:gmcweb/Antolin_home/antolin_main_2.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/details_page.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/maintenance_page.dart';
import 'package:gmcweb/CommonUi/logedInUser.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/linesMain.dart';
import 'package:gmcweb/Navbar/navBarMain.dart';
import 'package:gmcweb/Reports/reportsMain.dart';
import 'package:gmcweb/Users/usersMain.dart';

class gmcHome extends StatefulWidget {
  const gmcHome({super.key});

  @override
  _gmcHomeState createState() => _gmcHomeState();
}

class _gmcHomeState extends State<gmcHome> {
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
      body: Stack(
        children: [
          Row(
            children: [
              NavBarMain(
                initialIndex: _selectedIndex,
                onTabSelected: _onTabSelected,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                        height: 65), // Space for the floating user container
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
                          Navigator(
                            key: _navigatorKeys[0],
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (_) => AntolinMain(),
                              // builder: (_) => AntolinMainTwo(),      keita pages
                              // builder: (_) => DetailsPage(),         keita pages
                              // builder: (_) => MaintenancePage(),     keita pages
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
          Positioned(
            top: 0,
            left: 80, // Aligns with NavBar width
            right: 0,
            child: Container(
              height: 65,
              width: MyUtility(context).width - 80,
              color: Colors.white
                  .withOpacity(0.9), // Slight opacity for floating effect
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/antolinLogo.png', height: 50),
                  LogedInUser(
                    userName: 'John Smith',
                    userRole: 'Production Manager',
                    userImage: 'images/person.jpg',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
