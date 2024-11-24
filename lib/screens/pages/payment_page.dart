import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late FocusNode _phoneNumberFocusNode;
  late FocusNode _addressFocusNode;
  @override
  void initState() {
    _phoneNumberFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  void _submit() {
    if (_phoneNumberController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Invalid Input',
          ),
          content: const Text(
            'Please make sure a valid phone number  and  Address was enterd  ',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        ),
      );
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset("assets/images/done.png"),
          content: const Text(
            'Your Order Done Successfully',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _phoneNumberFocusNode.unfocus();
        _addressFocusNode.unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Payment',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 250.0,
                    child: Text(
                      "Complete Your  Payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    focusNode: _phoneNumberFocusNode,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration:
                        _buildInputDecoration('Phone Number', Icons.call),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    focusNode: _addressFocusNode,
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: _buildInputDecoration('Address', Icons.home),
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  const ListTile(
                    title: Text(
                      'Cach on delivry',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.pedal_bike_rounded,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.kPrimaryColor),
                          onPressed: _submit,
                          child: const Text("Submit Order",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)))),
                ],
              ),
            ),
          )),
    );
  }
}

InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
  return InputDecoration(
      fillColor: Colors.grey[50],
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      filled: true,
      labelStyle: const TextStyle(color: Colors.black),
      labelText: label,
      suffixIcon: Icon(
        suffixIcon,
        color: Colors.black,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}
