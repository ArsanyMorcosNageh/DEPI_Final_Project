import 'package:ecommerce_app/screens/auth/reg.dart';
import 'package:ecommerce_app/screens/auth/widgets/customText.dart';
import 'package:ecommerce_app/screens/auth/widgets/customTextButton.dart';
import 'package:ecommerce_app/screens/auth/widgets/showSnackBar.dart';
import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:ecommerce_app/screens/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;

  bool _isPasswordVisible = false;
  bool isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // Allow resizing when the keyboard is visible
        body: SingleChildScrollView(
          // Wrap content to make it scrollable
          child: Stack(
            children: [
              // Background gradient
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Color(0xff281537),
                  ]),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 60.0, left: 22),
                  child: Text(
                    'Hello\nSign in!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Foreground container
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Email field
                          TextFormFieldCallBack(
                            onChanged: (value) {
                              email = value;
                            },
                            suffexIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            dataLabelText: 'Email',
                          ),
                          const SizedBox(height: 20),
                          // Password field
                          TextFormFieldCallBack(
                            onChanged: (value) {
                              password = value;
                            },
                            suffexIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            obscureText: !_isPasswordVisible,
                            dataLabelText: 'password',
                          ),
                          const SizedBox(height: 70),
                          // Sign In button
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                isLoading = true;
                                setState(() {});
                                try {
                                  await loginUsers();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainScreen(email: email),
                                    ),
                                  );
                                } on FirebaseAuthException catch (ex) {
                                  if (ex.code == 'user-not-found') {
                                    showSnackBar(context, 'User not found');
                                  } else if (ex.code == 'wrong-password') {
                                    showSnackBar(context, 'Wrong password');
                                  } else {
                                    print(ex.message);
                                  }
                                } catch (ex) {
                                  showSnackBar(context, 'There was an error');
                                }
                                isLoading = false;
                                setState(() {});
                              } else {
                                showSnackBar(
                                    context, 'Please enter email and password');
                              }
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(colors: [
                                  Colors.blue,
                                  Color(0xff281537),
                                ]),
                              ),
                              child: const Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 61, 63, 204),
                                    fontSize: 16),
                              ),
                              CustomTextButton(
                                text: "Sign up",
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegScreen()),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUsers() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
