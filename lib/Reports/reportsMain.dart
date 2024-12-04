import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/mySerachBar.dart';

import '../CommonUi/smallButtons.dart';
import '../CommonUi/stackedHeaders.dart';
import '../Constants/gmcColors.dart';
import '../Constants/myutility.dart';

class ReportsMain extends StatefulWidget {
  const ReportsMain({super.key});

  @override
  State<ReportsMain> createState() => _ReportsMainState();
}

class _ReportsMainState extends State<ReportsMain> {
  @override
  Widget build(BuildContext context) {
    final searchLineID = TextEditingController();

    return SizedBox(
      width: MyUtility(context).width - 280,
      height: MyUtility(context).height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            StackedHeaders(constrianedWidth: 450, width: 445, header: 'Users'),
            const SizedBox(
              height: 15,
            ),
            MySearchBar(textController: searchLineID, hintText: 'Search Line ID'),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
