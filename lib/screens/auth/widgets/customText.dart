import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldCallBack extends StatefulWidget {
  TextFormFieldCallBack({
    Key? key,
    required this.dataLabelText,
    this.data,
    this.onChanged,
    this.obscureText = false,
    required this.suffexIcon,
  }) : super(key: key);

  final TextEditingController? data;
  final String dataLabelText;
  final Widget suffexIcon;
  final bool obscureText;
  Function(String)? onChanged;

  @override
  State<TextFormFieldCallBack> createState() => _TextFormFieldCallBackState();
}

class _TextFormFieldCallBackState extends State<TextFormFieldCallBack> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Validate if the value is empty
      validator: (value) => value!.isEmpty ? 'Please enter a value' : null,
      onChanged: widget.onChanged,
      controller: widget.data,
      obscureText: widget.obscureText,
      style: const TextStyle(color: Colors.black), // Set the text color
      decoration: InputDecoration(
        suffixIcon: widget.suffexIcon,
        label: Text(
          widget.dataLabelText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
