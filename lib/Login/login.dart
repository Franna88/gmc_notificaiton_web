import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/group_button.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/gmcHome.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 400,
            height: MyUtility(context).height,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 280,
                  child: Image.asset(
                    'images/GMC_Logo_White_Background_Black_Text 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 400, // Match the width of the container
                  child: Image.asset(
                    'images/swirl.png',
                    fit: BoxFit.cover, // Ensures the image scales properly
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MyUtility(context).width - 400,
            height: MyUtility(context).height,
            child: Stack(
              children: [
                // Background image
                Container(
                  height: MyUtility(context).height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'images/car_manufacturing.jpeg'), // Replace with your image path
                      fit: BoxFit.cover, // Adjust fit as needed
                    ),
                  ),
                ),
                // Shadow overlay for the background image only
                Container(
                  height: MyUtility(context).height,
                  color: Colors.black.withOpacity(0.5), // Dark shadow overlay
                ),
                // White container to stay on top of the image
                Center(
                  child: Container(
                    width: MyUtility(context).width * 0.32,
                    height: MyUtility(context).height * 0.65,
                    child: Stack(
                      children: [
                        // Orange container positioned slightly off-center
                        Positioned(
                          bottom: 14, // Adjusted for better positioning
                          right:
                              10, // Adjusted to align off-center to the right
                          child: Container(
                            decoration: BoxDecoration(
                              color: GmcColors().orange,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            width: MyUtility(context).width * 0.30,
                            height: MyUtility(context).height * 0.6,
                          ),
                        ),
                        // White container centered on the screen
                        Center(
                          child: Container(
                            width: MyUtility(context).width * 0.30,
                            height: MyUtility(context).height * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Admin Portal',
                                    style: TextStyle(
                                      color: GmcColors().black,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  BlackTextField(
                                      title: 'Email',
                                      controller: _loginEmailController),
                                  SizedBox(
                                      height: MyUtility(context).height * 0.05),
                                  BlackTextField(
                                      title: 'Password',
                                      controller: _loginPasswordController),
                                  Spacer(),
                                  GroupButton(
                                      buttonText: 'Login',
                                      centerText: true,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GmcHome(),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
