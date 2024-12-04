import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class UserIconContainer extends StatelessWidget {
  final String userName;
  const UserIconContainer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(),
              color: GmcColors().black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Image.asset('images/User.png'),
            ),
          ),
          const Spacer(),
          Text(
            userName,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
