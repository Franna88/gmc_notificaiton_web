import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';

class NavButtons extends StatefulWidget {
  final String imageIcon;
  final Function() onTap;
  final bool isActive; // Add the isActive parameter

  const NavButtons(
      {super.key,
      required this.imageIcon,
      required this.onTap,
      required this.isActive});

  @override
  State<NavButtons> createState() => _NavButtonsState();
}

class _NavButtonsState extends State<NavButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
                217, 217, 217, 1), // Change color based on isActive
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
              color: GmcColors().antolinTeal,
            ),
          ),
          child: Center(
            child: Image.asset(widget.imageIcon,
                color: widget.isActive
                    ? GmcColors().antolinTeal
                    : GmcColors()
                        .antolinBlack // Change icon color based on isActive
                ),
          ),
        ),
      ),
    );
  }
}
