import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolBarHeight;
  const CustomAppBar(
      {super.key, required this.title, this.toolBarHeight = 56.0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight);
}
