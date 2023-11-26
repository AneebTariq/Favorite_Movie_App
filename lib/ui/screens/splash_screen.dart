import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/constents/size_config.dart';
import 'package:movie_app/config/styles/app_colors.dart';
import 'package:movie_app/config/styles/app_images.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.splashIcon,
              height: getHeight(180),
            ),
          ),
          SizedBox(
            height: getHeight(20),
          ),
          Center(
            child: Text(
              'The Movie App',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: getFont(25),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
