import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableSmallGreyContainer extends StatelessWidget {
  final double width;
  final String customText;
  final String whiteContents;
  final bool addIcon;

  const ReusableSmallGreyContainer({
    super.key,
    required this.width,
    required this.customText,
    required this.whiteContents,
    this.addIcon = false, // Default value set to false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtility(context).height * 0.05,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GmcColors().antolinBlack,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customText,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            height: MyUtility(context).height * 0.03,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Text(
                      whiteContents,
                      style: GoogleFonts.poppins(
                        color: GmcColors().antolinBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (addIcon) ...[
                      // Only adds the icon if addIcon is true
                      const SizedBox(width: 4),
                      Icon(
                        Icons.schedule,
                        color: GmcColors().antolinBlack,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
