import 'package:ecommerce_app/screens/auth/login.dart';
import 'package:ecommerce_app/screens/auth/widgets/customText.dart';
import 'package:ecommerce_app/screens/auth/widgets/customTextButton.dart';
import 'package:ecommerce_app/screens/auth/widgets/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);
  static String id = '/RegScreen';

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool isLoading = false;
  String? email, password, fullName;
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _validateAndRegister() {
    if (_formKey.currentState!.validate()) {
      // Handle registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Registration...')),
      );
    }
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
                    'Create Your\nAccount',
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
                          TextFormFieldCallBack(
                            onChanged: (value) {
                              fullName = value;
                            },
                            suffexIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            dataLabelText: 'Full Name',
                          ),
                          const SizedBox(height: 20),
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

                          const SizedBox(height: 20),

                          const SizedBox(height: 70),
                          // Register Button
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await registerUser();

                                  // After successfully registering the user, add user data to Firestore
                                } on FirebaseAuthException catch (ex) {
                                  if (ex.code == 'weak-password') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackBar(context, 'Weak password');
                                  } else if (ex.code ==
                                      'email-already-in-use') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackBar(
                                        context, 'Email already in use');
                                  }
                                }
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
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 61, 63, 204),
                                    fontSize: 16),
                              ),
                              CustomTextButton(
                                text: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
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

  Future<void> registerUser() async {
    try {
      if (email != null) {
        // Register user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        // Get the UID of the newly registered user
        String uid = userCredential.user!.email!; // Use email as UID
        await addUserToFirestore(uid);
        showSnackBar(context, 'Registration is done.');

        // Add user data to Firestore using the obtained UID (email)
        await addUserToFirestore(uid);
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Domain not supported.');
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Weak password');
      } else if (ex.code == 'email-already-in-use') {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Email already in use');
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Error: ${ex.message}');
      }
    }
  }

  Future<void> addUserToFirestore(String uid) async {
    // Add user data to Firestore using the email as the document ID (UID)
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'fullNmme': fullName,
    });
    setState(() {
      FirebaseAuth.instance.signOut();
      isLoading = false;
    });
  }
}
