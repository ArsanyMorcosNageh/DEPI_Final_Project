// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last, curly_braces_in_flow_control_structures, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/auth/login.dart';
import 'package:ecommerce_app/screens/auth/widgets/customTextBox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
 

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String id = 'Accountinfo';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    Future<void> _deleteAccount() async {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          // Show confirmation dialog
          bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Account'),
              content:
                  const Text('Are you sure you want to delete your account?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );

          if (confirm == true) {
            // Delete user from Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.email) // Use email as document ID
                .delete();

            // Delete user from Firebase Authentication
            await currentUser.delete();

            // Navigate back to login page
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
          }
        } else {
          throw Exception('User is not logged in');
        }
      } catch (e) {
        // Handle errors here

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Failed to delete account. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    Future<void> _updateUsername(String newUsername) async {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          // Update username in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email) // Use email as document ID
              .update({'username': newUsername});
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username updated successfully')),
          );
          setState(() {
            _usernameController.text = newUsername;
          });
        } else {
          throw Exception('User is not logged in');
        }
      } catch (e) {
        // Handle errors here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update username')),
        );
      }
    }

    void _showChangeUsernameDialog(String currentUsername) {
      TextEditingController dialogController =
          TextEditingController(text: currentUsername);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          GlobalKey<FormState> _formKey =
              GlobalKey<FormState>(); // Add a Form key for validation
          return StatefulBuilder(
            // Use StatefulBuilder to update the dialog's state
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Change Username'),
                content: Form(
                  key: _formKey, // Use the form key here
                  child: TextFormField(
                    controller: dialogController,
                    decoration:
                        const InputDecoration(labelText: 'New Username'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      // Update the state of the dialog to enable/disable the save button
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username cannot be empty'; // Ensure username is not empty
                      }
                      return null; // Return null if no error
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: dialogController.text.trim().isEmpty
                        ? null // Disable the Save button if the text field is empty or only spaces
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _updateUsername(dialogController.text.trim());
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please enter a valid username.')));
                            }
                          },
                    child: Text('Save'),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled))
                            return Colors.grey; // Grey out the text if disabled
                          return null; // Use the default foreground color
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 59, 136),
        elevation: 0,
        title: const Text(
          ' My Profile ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Implement the action you want when the back button is pressed
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.email) // Use email as document ID
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            final userData = snapshot.data!.data();
            if (userData != null && userData is Map<String, dynamic>) {
              final username = userData['fullNmme'] as String?;
              final email = userData['email'] as String?;
              if (username != null && email != null) {
                _usernameController.text = username;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Icon(
                        Icons.person,
                        size: 80,
                      ),
                      Center(
                        child: Text(
                          ' $email',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'My Details',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      MyTextBox(
                        text: '$username',
                        sectionName: 'Full Name : ',
                        onPressed: () {
                          _showChangeUsernameDialog(_usernameController.text);
                        },
                      ),
                      MyTextBox(
                        text: '$email',
                        sectionName: 'Email : ',
                      ),
                      GestureDetector(
                        onTap: () {
                          _deleteAccount();
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
                              'Delete Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          }
          return const Center(
            child: Text('User data format error'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
