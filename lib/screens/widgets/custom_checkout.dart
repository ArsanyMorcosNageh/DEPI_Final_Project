import 'package:ecommerce_app/screens/pages/payment_page.dart';
import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:flutter/material.dart';

class CustomCheckOut extends StatelessWidget {
  const CustomCheckOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentPage(),
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.kPrimaryColor,
          ),
          child: const Text(
            'Checkout',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
