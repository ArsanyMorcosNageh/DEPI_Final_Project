import 'package:flutter/material.dart';

class UsersSolidCard extends StatelessWidget {
  const UsersSolidCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 100,
            height: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            width: 80,
            height: 16,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
