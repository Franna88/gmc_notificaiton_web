import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Users/UserTable/ui/tableStructure.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {
        'name': 'James Harmse',
        'email': 'james@gmail.com',
        'contactNo': '099 222 333'
      },
      {
        'name': 'James Harmse',
        'email': 'james@gmail.com',
        'contactNo': '099 222 333'
      },
      {
        'name': 'James Harmse',
        'email': 'james@gmail.com',
        'contactNo': '099 222 333'
      }
    ];

    return Container(
      height: MyUtility(context).height - 205,
      width: MyUtility(context).width - 340,
      decoration: BoxDecoration(
          border: Border.all(color: GmcColors().black),
          color: GmcColors().lightGrey),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: GmcColors().black,
            ),
            children: [
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Name',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Email',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Contact No',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(
            users.length,
            (index) {
              final user = users[index];
              return TableRow(
                decoration: BoxDecoration(
                  color: index % 2 == 1
                      ? Colors.white
                      : Color.fromRGBO(209, 210, 146, 0),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: GmcColors().black,
                    ),
                  ),
                ),
                children: [
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['name']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['email']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['contactNo']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
