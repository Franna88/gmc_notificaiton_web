import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableContainersWithHeaders extends StatelessWidget {
  final String customText;
  final double customWidth;
  final Widget containerContents;

  const ReusableContainersWithHeaders({
    super.key,
    required this.customText,
    required this.customWidth,
    required this.containerContents,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: customWidth,
          height: MyUtility(context).height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            color: GmcColors().antolinBlack,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  customText,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: customWidth,
          height: MyUtility(context).height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)),
            color: Colors.white,
          ),
          child: containerContents,
        ),
      ],
    );
  }
}
