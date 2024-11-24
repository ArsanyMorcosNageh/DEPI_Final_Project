import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    _buildPageViewModel(
      title: "Welcome to Your Shopping Hub",
      body: "Discover an amazing collection of products tailored just for you.",
      imagePath: 'assets/images/choose.png',
    ),
    _buildPageViewModel(
      title: "See Products & Details",
      body:
          "Explore products in detail, with all the information you need to make a choice.",
      imagePath: 'assets/images/product.png',
    ),
    _buildPageViewModel(
      title: "Easy & Secure Payments",
      body:
          "Pay confidently with our secure checkout options designed for your convenience.",
      imagePath: 'assets/images/smartpay.png',
    ),
    _buildPageViewModel(
      title: "Receive Your Package",
      body: "Enjoy fast and reliable delivery straight to your doorstep.",
      imagePath: 'assets/images/package.png',
    ),
  ];

  static PageViewModel _buildPageViewModel({
    required String title,
    required String body,
    required String imagePath,
  }) {
    return PageViewModel(
      title: title,
      body: body,
      image: Center(
        child: Image.asset(
          imagePath,
        ),
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
      ),
    );
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen(email: '',)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(
                255, 255, 255, 255), // Change color as needed
          )),
      body: Column(
        children: [
          // AppBar is already included in Scaffold, no need to repeat here
          Expanded(
            child: IntroductionScreen(
              pages: pages,
              showSkipButton: true,
              skip: const Text(
                'Skip',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              next: const Text(
                'Next',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              done: const Text(
                'Done',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onDone: () => _onIntroEnd(context),
              onSkip: () => _onIntroEnd(context),
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Theme.of(context).colorScheme.secondary,
                color: Colors.blue,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
