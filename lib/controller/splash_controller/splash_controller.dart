import 'dart:async';

import 'package:admin_ticead/view/login/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
   RxBool? loginvalue = false.obs;
   
   @override
  void onInit() {
   intro();
    super.onInit();
  }

intro(){
//   Timer(Duration(seconds: 3), () {
//   print("Yeah, this line is printed after 3 seconds");
// });
//  await Future.delayed(const Duration(seconds: 3));
  Future.delayed(const Duration(seconds: 5), () async {
      await Get.off(() => LoginScreen());
    });
}
  
}