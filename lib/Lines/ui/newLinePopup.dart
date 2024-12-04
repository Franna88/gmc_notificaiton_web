import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class NewLinePopup extends StatefulWidget {
  final Function(String) onAddLine; 

  const NewLinePopup({super.key, required this.onAddLine});

  @override
  State<NewLinePopup> createState() => _NewLinePopupState();
}

class _NewLinePopupState extends State<NewLinePopup> {
  final lineIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 300,
            decoration: BoxDecoration(
              color: GmcColors().black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('images/backArrow.png'),
                  ),
                  const Spacer(),
                  Text(
                    'NEW LINE',
                    style: GoogleFonts.roboto(
                      color: GmcColors().orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: BlackTextField(
              title: 'Line ID',
              controller: lineIDController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButtons(
                  onTap: () {
                    if (lineIDController.text.isNotEmpty) {
                      widget.onAddLine(lineIDController.text); 
                      Navigator.pop(context); 
                    }
                  },
                  buttonText: 'Accept',
                  buttonColor: GmcColors().orange,
                ),
                SmallButtons(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttonText: 'Cancel',
                  buttonColor: GmcColors().red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
