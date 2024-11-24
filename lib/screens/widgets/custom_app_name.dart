import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppName extends StatelessWidget {
  const CustomAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      baseColor: Colors.black,
      highlightColor: Colors.blue,
      child: const Text(
        'Shop Smart',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
