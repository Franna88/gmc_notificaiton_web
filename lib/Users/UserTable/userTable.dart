import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Users/UserTable/ui/tableStructure.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTable extends StatelessWidget {
  final List<Map<String, String>> users;

  const UserTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtility(context).height - 205,
      width: MyUtility(context).width - 340,
      decoration: BoxDecoration(
        border: Border.all(color: GmcColors().black),
        color: GmcColors().lightGrey,
      ),
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
                      fontSize: 20,
                    ),
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
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // TableStructure(
              //   child: TableCell(
              //     child: Text(
              //       'Contact No',
              //       style: GoogleFonts.roboto(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              // TableStructure(
              //   child: TableCell(
              //     child: Text(
              //       'Current Password',
              //       style: GoogleFonts.roboto(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          ...List.generate(
            users.length,
            (index) {
              final user = users[index];
              return TableRow(
                decoration: BoxDecoration(
                  color: index % 2 == 1 ? Colors.grey[200] : Colors.white,
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
                  // TableStructure(
                  //   child: TableCell(
                  //     child: Text(
                  //       user['contactNo']!,
                  //       style: GoogleFonts.roboto(fontSize: 18),
                  //     ),
                  //   ),
                  // ),
                  // TableStructure(
                  //   child: TableCell(
                  //     child: Text(
                  //       user['password']!,
                  //       style: GoogleFonts.roboto(fontSize: 18),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
