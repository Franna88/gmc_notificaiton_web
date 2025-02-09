import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';

class RowOneGreyContainers extends StatelessWidget {
  final Widget? contents;
  const RowOneGreyContainers({
    super.key,
    this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: GmcColors().antolinBlack,
        ),
        child: contents,
      ),
    );
  }
}
