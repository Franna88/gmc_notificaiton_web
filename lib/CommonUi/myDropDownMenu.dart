import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropDownMenu extends StatefulWidget {
  double customSize;
  String? description;
  final bool? focusTap;
  List items;
  final bool? enableSearch;
  final bool? isBold;
  final TextEditingController textfieldController;
  final Function? onChanged;
  MyDropDownMenu(
      {super.key,
      required this.customSize,
      this.description,
      required this.items,
      required this.textfieldController,
      this.isBold,
      this.onChanged,
      this.enableSearch,
      this.focusTap});

  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: GmcColors().black),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: DropdownMenu<String>(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          focusColor: Colors.white,
          contentPadding: EdgeInsets.only(bottom: 15, left: 5),
          border: InputBorder.none,
        ),
        hintText: 'Select',
        textStyle: GoogleFonts.inter(color: Colors.grey),
        trailingIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 35,
        ),
        selectedTrailingIcon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.black,
          size: 35,
        ),
        enableFilter: false,
        enableSearch: widget.enableSearch ?? true,
        width: widget.customSize,
        controller: widget.textfieldController,
        requestFocusOnTap: widget.focusTap ?? true,
        label: const Text(''),
        onSelected: (value) {
          setState(() {
            widget.textfieldController.text = value!;
          });

          if (widget.onChanged != null) {
            widget.onChanged!();
          }
        },
        dropdownMenuEntries:
            widget.items.map<DropdownMenuEntry<String>>((value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
            style: ButtonStyle(
              surfaceTintColor: WidgetStateProperty.all(Colors.white),
              backgroundColor:
                  WidgetStateProperty.all(Colors.white), // Background color
              overlayColor:
                  WidgetStateProperty.all(Colors.grey[200]), // Hover effect
              foregroundColor:
                  WidgetStateProperty.all(Colors.black), // Text color
            ),
          );
        }).toList(),
      ),
    );
  }
}
