import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final double? width; // Optional width property
  const BlackTextField({
    super.key,
    required this.title,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.width, // Optional parameter for width
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8), // Space between title and text field
        SizedBox(
          width: width, // Apply width if provided
          height: 50, // Fixed height
          child: TextField(
            cursorColor: Colors.white,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: GmcColors().black,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: GmcColors().black),
                borderRadius:
                    const BorderRadius.all(Radius.circular(6)), // Border radius
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GmcColors().black),
                borderRadius:
                    const BorderRadius.all(Radius.circular(6)), // Border radius
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GmcColors().black),
                borderRadius:
                    const BorderRadius.all(Radius.circular(6)), // Border radius
              ),
            ),
          ),
        ),
      ],
    );
  }
}
