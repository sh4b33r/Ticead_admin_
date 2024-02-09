import 'package:admin_ticead/controller/splash_controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  
  const SplashScreen({super.key});
  
  
  @override
  Widget build(BuildContext context) {
     Get.put(SplashController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'asset/lottie/Animation - 1707142660810.json',
              height: 90,
              width: 60,
            ),
          )
        ],
      ),
    );
  }
}
