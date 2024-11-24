import 'package:flutter/material.dart';

class UsersCard extends StatelessWidget {
  final dynamic user;
  const UsersCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            child: Text(
              '${user['name']['firstname'][0]}${user['name']['lastname'][0]}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${user['name']['firstname']}${user['name']['lastname']}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${user['email']}',
          ),
        ],
      ),
    );
  }
}
