import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogedInUser extends StatefulWidget {
  final String userName;
  final String userRole;
  final String userImage;
  const LogedInUser(
      {super.key,
      required this.userName,
      required this.userRole,
      required this.userImage});

  @override
  State<LogedInUser> createState() => _LogedInUserState();
}

class _LogedInUserState extends State<LogedInUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.userName,
                style:
                    GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              Text(
                widget.userRole,
                style:
                    GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(width: 20,),
          Container(
            height: 50,
            width: 50,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(widget.userImage),
              ),
              shape: CircleBorder(),
            ),
          )
        ],
      ),
    );
  }
}
