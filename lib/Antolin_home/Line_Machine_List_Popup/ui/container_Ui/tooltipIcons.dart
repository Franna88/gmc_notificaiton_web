import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class TooltipIcons extends StatefulWidget {
  final String iconType;
  const TooltipIcons({super.key, required this.iconType});

  @override
  State<TooltipIcons> createState() => _TooltipIconsState();
}

class _TooltipIconsState extends State<TooltipIcons> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textStyle: GoogleFonts.inter(
          color: widget.iconType == 'maintenance'
              ? GmcColors().orange
              : widget.iconType == 'faultyPart'
                  ? GmcColors().red
                  : null),
      message: widget.iconType == 'maintenance'
          ? 'Maintenance'
          : widget.iconType == 'faultyPart'
              ? 'Faulty Part Detected'
              : '',
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: GmcColors().antolinBlack),
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: GmcColors().antolinBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Image.asset(widget.iconType == 'maintenance' ? 'images/toolIcon.png' : widget.iconType == 'faultyPart'
                ?  'images/warningIcon.png' : 'images/warningIcon.png'),
          ),
        ),
      ),
    );
  }
}
