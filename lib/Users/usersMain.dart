import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Users/UserTable/userTable.dart';

import '../Constants/gmcColors.dart';

class UsersMain extends StatefulWidget {
  const UsersMain({super.key});

  @override
  State<UsersMain> createState() => _UsersMainState();
}

class _UsersMainState extends State<UsersMain> {
  @override
  Widget build(BuildContext context) {
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
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SmallButtons(
                onTap: (){},
                buttonText: 'Add User',
                buttonColor: GmcColors().teal,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            UserTable()
          ],
        ),
      ),
    );
  }
}
