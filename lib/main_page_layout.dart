import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/CommonUi/logedInUser.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/linesMain.dart';
import 'package:gmcweb/Navbar/navBarMain.dart';
import 'package:gmcweb/Reports/reportsMain.dart';
import 'package:gmcweb/Users/usersMain.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({super.key});

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final PageController _pageController = PageController();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  void changePage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavBarMain(changePage: changePage),
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
                          userImage: 'images/person.jpg')
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    key: _navigatorKey,
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      LinesMain(user: _currentUser),
                      UsersMain(user: _currentUser),
                      ReportsMain(user: _currentUser),
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
