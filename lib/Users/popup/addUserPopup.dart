import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CommonUi/smallButtons.dart';
import '../../Constants/gmcColors.dart';

class AddUserPopup extends StatefulWidget {
  final Function(String name, String email, String contactNo, String password)
      onAddUser;

  const AddUserPopup({super.key, required this.onAddUser});

  @override
  State<AddUserPopup> createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final nameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Header section
          Container(
            height: 70,
            width: 550,
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
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('images/backArrow.png'),
                  ),
                  const Spacer(),
                  Text(
                    'NEW USER',
                    style: GoogleFonts.roboto(
                      color: GmcColors().orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
    
          // Input fields for name and contact number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlackTextField(
                  title: 'Name',
                  controller: nameController,
                  width: 235,
                ),
                BlackTextField(
                  title: 'Contact Number',
                  controller: contactNumberController,
                  width: 235,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
    
          // Stacked header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StackedHeaders(
                constrianedWidth: 350,
                width: 345,
                header: 'Enter User Login Details',
              ),
            ),
          ),
          const SizedBox(height: 30),
    
          // Input fields for email and password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlackTextField(
                  title: 'Email',
                  controller: emailController,
                  width: 235,
                ),
                BlackTextField(
                  title: 'User Password',
                  controller: userPasswordController,
                  width: 235,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
    
          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmallButtons(
                  onTap: () {
                    widget.onAddUser(
                      nameController.text,
                      emailController.text,
                      contactNumberController.text,
                      userPasswordController.text,
                    );
                  },
                  buttonText: 'Accept',
                  buttonColor: GmcColors().orange,
                ),
                const SizedBox(width: 30),
                SmallButtons(
                  onTap: () => Navigator.pop(context),
                  buttonText: 'Cancel',
                  buttonColor: GmcColors().red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
