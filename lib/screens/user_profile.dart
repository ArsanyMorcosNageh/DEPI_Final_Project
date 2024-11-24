import 'package:ecommerce_app/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final dynamic user;
  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile Page"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  child: Text(
                    '${user['name']['firstname'][0]}${user['name']['lastname'][0]}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
                title: Text(
                  '${user['name']['firstname']}${user['name']['lastname']}',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '${user['email']}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  user['username'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  user['phone'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(
                  '${user['address']['number']}, ${user['address']['street']}, ${user['address']['city']}, ${user['address']['zipcode']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
