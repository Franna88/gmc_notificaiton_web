import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/Antolin_home/Shyft_Report/shyftReport.dart';
import 'package:gmcweb/Antolin_home/antolin_main_2.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/details_page.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/maintenance_page.dart';
import 'package:gmcweb/Antolin_reports/AntolinRepontsMain.dart';
import 'package:gmcweb/CommonUi/logedInUser.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Navbar/navBarMain.dart';
import 'package:gmcweb/Reports/reportsMain.dart';
import 'package:gmcweb/Users/usersMain.dart';

class GmcHome extends StatefulWidget {
  const GmcHome({super.key});

  @override
  State<GmcHome> createState() => _GmcHomeState();
}

class _GmcHomeState extends State<GmcHome> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Lines
    GlobalKey<NavigatorState>(), // Users
    GlobalKey<NavigatorState>(), // Reports
    GlobalKey<NavigatorState>(), // Maintenance
    GlobalKey<NavigatorState>(), // Details
    GlobalKey<NavigatorState>(), //Shydt Report
  ];

  void navigatorTo(int keyIndex, Widget page) {
    print("Switching to Tab: $keyIndex");

    setState(() {
      _selectedIndex = keyIndex; // Switch to the correct tab
    });

    final navigatorState = _navigatorKeys[keyIndex].currentState;
    if (navigatorState == null) {
      print("NavigatorState is NULL for index $keyIndex!");
      return;
    } else {
      print("NavigatorState found for index $keyIndex!");
    }

    // Push page inside the correct Navigator, keeping the top & side nav
    navigatorState.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

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
                    const SizedBox(
                        height: 65), // Space for the floating user container
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
                          Navigator(
                            key: _navigatorKeys[0],
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (_) =>
                                  AntolinMainTwo(navigateToPage: navigatorTo),
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
                              builder: (_) => const AntolinReportsMain(),
                            ),
                          ),
                          Navigator(
                            key: _navigatorKeys[3],
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (_) => const MaintenancePage(),
                            ),
                          ),
                          Navigator(
                            key: _navigatorKeys[4],
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (_) => const DetailsPage(),
                            ),
                          ),
                          Navigator(
                            key: _navigatorKeys[5],
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (_) => ShyftReport(),
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
                  const LogedInUser(
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
