import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class NavButtons extends StatefulWidget {
  final String buttonText;
  final bool isActive;
  final Function() onTap;
  const NavButtons(
      {super.key,
      required this.isActive,
      required this.buttonText,
      required this.onTap});

  @override
  State<NavButtons> createState() => _NavButtonsState();
}

class _NavButtonsState extends State<NavButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: 240,
          height: 45,
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.5,
              color: widget.isActive ? GmcColors().orange : Colors.white,
            ),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: GoogleFonts.roboto(
                color: widget.isActive ? GmcColors().orange : Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }
}
