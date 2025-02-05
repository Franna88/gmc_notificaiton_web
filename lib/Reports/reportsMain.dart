import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/myDropDownMenu.dart';
import 'package:gmcweb/CommonUi/mySerachBar.dart';
import 'package:gmcweb/Reports/Table/reportsTable.dart';

import '../CommonUi/smallButtons.dart';
import '../CommonUi/stackedHeaders.dart';
import '../Constants/gmcColors.dart';
import '../Constants/myutility.dart';

class ReportsMain extends StatefulWidget {
  final User? user;
  const ReportsMain({super.key, required this.user});

  @override
  State<ReportsMain> createState() => _ReportsMainState();
}

class _ReportsMainState extends State<ReportsMain> {
  @override
  Widget build(BuildContext context) {
    final searchLineID = TextEditingController();
    final monthDropMenu = TextEditingController();

    return Scaffold(
      body: SizedBox(
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              StackedHeaders(
                  constrianedWidth: 450, width: 445, header: 'Users'),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  MySearchBar(
                      textController: searchLineID, hintText: 'Search Line ID'),
                  const SizedBox(
                    width: 30,
                  ),
                  MyDropDownMenu(
                      customSize: 300,
                      items: [
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December'
                      ],
                      textfieldController: monthDropMenu)
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ReportsTable()
            ],
          ),
        ),
      ),
    );
  }
}
