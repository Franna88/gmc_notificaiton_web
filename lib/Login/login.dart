import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/group_button.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Layout&Nav/gmcHome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _loginEmailController =
      TextEditingController(text: 'suptest@gmail.com');
  final TextEditingController _loginPasswordController =
      TextEditingController(text: 'test123');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );

      // Navigate to the home screen on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => gmcHome()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                const SizedBox(height: 50),
                SizedBox(
                  width: 280,
                  child: Image.asset(
                    'images/GMC_Logo_White_Background_Black_Text 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 400,
                  child: Image.asset(
                    'images/swirl.png',
                    fit: BoxFit.cover,
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
                Container(
                  height: MyUtility(context).height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/car_manufacturing.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MyUtility(context).height,
                  color: Colors.black.withOpacity(0.5),
                ),
                Center(
                  child: Container(
                    width: MyUtility(context).width * 0.32,
                    height: MyUtility(context).height * 0.65,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 14,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: GmcColors().orange,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            width: MyUtility(context).width * 0.30,
                            height: MyUtility(context).height * 0.6,
                          ),
                        ),
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
                                    controller: _loginEmailController,
                                  ),
                                  SizedBox(
                                      height: MyUtility(context).height * 0.05),
                                  BlackTextField(
                                    title: 'Password',
                                    controller: _loginPasswordController,
                                  ),
                                  if (_errorMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _errorMessage!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  Spacer(),
                                  _isLoading
                                      ? CircularProgressIndicator()
                                      : GroupButton(
                                          buttonText: 'Login',
                                          centerText: true,
                                          onTap: _login,
                                        ),
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
