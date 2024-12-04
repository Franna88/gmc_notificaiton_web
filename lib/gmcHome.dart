import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/linesMain.dart';
import 'package:gmcweb/Lines/ui/newLinePopup.dart';
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

  var pages = [
    LinesMain(),
    UsersMain(),
    ReportsMain(),
  ];


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
          NavBarMain(changePage: changePage,),
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
