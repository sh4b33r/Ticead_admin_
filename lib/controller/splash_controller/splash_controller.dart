import 'dart:async';
import 'dart:developer';
import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';
import 'package:admin_ticead/view/home/screen/home_screen.dart';
import 'package:admin_ticead/view/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  SplashController() {
    // try{
    //   Get.put(MovieController()).getdatatoAllMovies();
    // }catch(e){
    //   log('error aan work avane');
    //   Get.put(MovieController()).getdatatoAllMovies();
    // }
  }
  RxBool? loginvalue = false.obs;

  @override
  void onInit() {
    intro();

    super.onInit();
  }

  intro() async {
   
  
    // final shared = await SharedPreferences.getInstance();
  //  log(SharedPref().sharedInstance.getString('LoginState'));
  final shared = await SharedPreferences.getInstance();
    final checkvalue =  shared.getString('LoginState');

    if ( checkvalue == null || checkvalue == 'false') {
      Future.delayed(const Duration(seconds: 5), () async {
        await Get.off(() => const LoginScreen());
      });
    } else {
        await SharedPref().sharedisntancefucniton();
      Future.delayed(const Duration(seconds: 5), () async {
        await Get.off(() =>  HOmeScreen());
      });
    }
  }
}
