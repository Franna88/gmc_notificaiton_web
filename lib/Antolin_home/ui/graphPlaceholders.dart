import 'package:flutter/material.dart';

class GraphPlaceholders extends StatelessWidget {
  const GraphPlaceholders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Container(
          height: 300,
          width: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/downtimePlaceholder.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
