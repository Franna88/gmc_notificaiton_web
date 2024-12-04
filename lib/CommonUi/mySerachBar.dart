import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const MySearchBar(
      {required this.textController, required this.hintText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(color: GmcColors().black),
          boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
      child: TextField(
        cursorColor: GmcColors().black,
        controller: textController,
        onChanged: (value) {
          //Do something wi
        },
        decoration: InputDecoration(
          prefixIcon: Image.asset('images/searchIcon.png'),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          // border: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(45.0)),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: GmcColors().black, width: 1.0),
          //   borderRadius: BorderRadius.all(Radius.circular(45.0)),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: GmcColors().black, width: 1.5),
          //   borderRadius: BorderRadius.all(Radius.circular(45.0)),
          // ),
        ),
      ),
    );
  }
}
