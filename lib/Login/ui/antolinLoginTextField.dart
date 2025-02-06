import 'package:flutter/material.dart';

class AntolinLoginTextField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Widget icon;
  final String labelText;

  const AntolinLoginTextField({
    Key? key,
    required this.inputController,
    required this.hintText,
    required this.labelText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          suffixIcon: icon,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.grey.withOpacity(.75), fontSize: 15),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(0, 30, 100, 1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(0, 30, 100, 1), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(0, 30, 100, 1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
