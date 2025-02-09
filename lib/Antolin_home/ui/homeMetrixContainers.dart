import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMetrixContainers extends StatefulWidget {
  final String header;
  final Widget? child;
  const HomeMetrixContainers({
    super.key,
    required this.header,
    this.child,
  });

  @override
  State<HomeMetrixContainers> createState() => _HomeMetrixContainersState();
}

class _HomeMetrixContainersState extends State<HomeMetrixContainers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.header,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  color: Colors.white,
                  height: 2,
                  width: 260,
                ),
              ),
              widget.child ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
