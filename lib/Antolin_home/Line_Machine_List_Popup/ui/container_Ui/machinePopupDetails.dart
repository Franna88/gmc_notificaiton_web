import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MachinePopupDetails extends StatelessWidget {
  final String iconImage;
  final String detailName;
  final Widget child;
  const MachinePopupDetails(
      {super.key,
      required this.iconImage,
      required this.detailName,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iconImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          detailName,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 1.3
          ),
        ),
        const Spacer(),
        Container(
          height: 25,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Center(child: child,),
        )
      ],
    );
  }
}
