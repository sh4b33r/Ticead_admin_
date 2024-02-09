import 'dart:developer';

import 'package:admin_ticead/model/siginin/signin.dart';
import 'package:admin_ticead/view/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {




  tologin() async {
    final Map<String,String?>  email = await signInwithgoogle();
 log(email['name']!);
    if(email.isNotEmpty){
      Get.off(HOmeScreen());
    }else{
      Get.showSnackbar(GetSnackBar(backgroundColor: Colors.red,message: 'Login Failed',));
    }
  }
}
