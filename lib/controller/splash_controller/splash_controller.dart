import 'dart:async';
import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/view/home/screen/home_screen.dart';
import 'package:admin_ticead/view/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  RxBool? loginvalue = false.obs;

  @override
  void onInit()  {
    intro();
    
    super.onInit();
  }

  intro() async {
    final shared = await SharedPreferences.getInstance();
    
    final checkvalue = shared.getString('LoginState');
      await Get.put(MovieController()).getdatatoAllMovies();
    if (checkvalue == null || checkvalue == 'false') {
      Future.delayed(const Duration(seconds: 5), () async {
       
        await Get.off(() => const LoginScreen());
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () async {
         
        await Get.off(() => const HOmeScreen());
      });
    }

  }
}
