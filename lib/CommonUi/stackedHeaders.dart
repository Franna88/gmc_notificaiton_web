import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class StackedHeaders extends StatelessWidget {
  final double constrianedWidth;
  final double width;
  final String header;
  const StackedHeaders(
      {super.key,
      required this.constrianedWidth,
      required this.width,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 50,
      width: constrianedWidth,
      child: Stack(
        children: [
            Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 45,
              width: width,
              decoration: BoxDecoration(
                color: GmcColors().orange,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 45,
              width: width,
              decoration: BoxDecoration(
                color: GmcColors().black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    header,
                    style: GoogleFonts.roboto(
                      color: GmcColors().orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
