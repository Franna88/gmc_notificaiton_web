import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gmcweb/CommonUi/blackTextField.dart';
import 'package:gmcweb/CommonUi/group_button.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Login/ui/antolinLoginTextField.dart';
import 'package:gmcweb/gmcHome.dart';
import 'package:google_fonts/google_fonts.dart';

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
        MaterialPageRoute(builder: (context) => const GmcHome()),
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
      body: Container(
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/antolinLogin.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: MyUtility(context).width * 0.25,
            height: MyUtility(context).height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ANTOLIN Login',
                    style: TextStyle(
                      color: GmcColors().black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Please fill in your details below',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.3),
                  ),
                  const Spacer(),
                  AntolinLoginTextField(
                    inputController: _loginEmailController,
                    hintText: '',
                    labelText: 'Email',
                    icon: const Icon(Icons.person_outline),
                  ),
                  // BlackTextField(
                  //   title: 'Email',
                  //   controller: _loginEmailController,
                  // ),
                  SizedBox(height: MyUtility(context).height * 0.05),
                  // BlackTextField(
                  //   title: 'Password',
                  //   controller: _loginPasswordController,
                  // ),
                  AntolinLoginTextField(
                    inputController: _loginEmailController,
                    hintText: '',
                    labelText: 'Password',
                    icon: const Icon(Icons.password),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const Spacer(),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Center(
                          child: InkWell(
                            onTap: _login,
                            child: Container(
                              height: 60,
                              width: MyUtility(context).width * 0.18,
                              decoration: BoxDecoration(
                                color: GmcColors().antolinBlack,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )

                  // GroupButton(
                  //     buttonText: 'Login',
                  //     centerText: true,
                  //     onTap: _login,
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
