import 'package:ecommerce_app/screens/auth/login.dart';
import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:ecommerce_app/screens/pages/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashAnimation();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startSplashAnimation() {
    _controller.forward();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnboardingComplete = prefs.getBool('isOnboardingComplete');

    if (isOnboardingComplete == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  OnboardingScreen ()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>LoginScreen ()),
      );
      // Set the onboarding complete flag to true
      await prefs.setBool('isOnboardingComplete', true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RotationTransition(
            turns: _rotateAnimation,
            child: Image.asset(
              'assets/images/icon.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
