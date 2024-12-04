import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CausePopup extends StatefulWidget {
  const CausePopup({super.key});

  @override
  State<CausePopup> createState() => _CausePopupState();
}

class _CausePopupState extends State<CausePopup> {
  late TextEditingController _contentTitleController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _contentTitleController = TextEditingController();
  }

  @override
  void dispose() {
    _contentTitleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtility(context).height * 0.8,
      width: MyUtility(context).width * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: GmcColors().black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            width: MyUtility(context).width * 0.4,
            height: MyUtility(context).height * 0.07,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'images/backArrow.png',
                      fit: BoxFit.cover, // Ensures the image scales properly
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      'CAUSE',
                      style: TextStyle(
                        color: GmcColors().orange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Describe the issue:\n',
                    style: TextStyle(
                      color: GmcColors().black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: _contentTitleController,
                      maxLines: 5, // Allows the user to type multiple lines
                      decoration: InputDecoration(
                        hintText: 'Enter details here...',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: InputBorder.none, // Removes the default border
                      ),
                      style: TextStyle(
                        color: GmcColors().black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Text(
                    'Add an image:\n',
                    style: TextStyle(
                      color: GmcColors().black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                    height: MyUtility(context).height * 0.35,
                    width: MyUtility(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _selectedImage == null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[300], // Grey background color
                            ),
                            child: InkWell(
                              onTap: _pickImage, // Function to pick an image
                              child: Center(
                                child: Icon(
                                  Icons
                                      .add_a_photo, // Icon to indicate adding an image
                                  color: Colors.black,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: MyUtility(context).height * 0.35,
                            height: 150,
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
