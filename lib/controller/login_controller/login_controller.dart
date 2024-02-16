import 'dart:developer';

import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';
import 'package:admin_ticead/model/siginin/signin.dart';
import 'package:admin_ticead/view/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  
  String? id;
 

  tologin() async {
    final Map<String,String?>  email = await signInwithgoogle();
 log(email['name']!);

    if(email.isNotEmpty){

     
     var userId=await addUser(email['email'], email['name']);
 
        SharedPref.sharedprefset(userId);
       await sharedtocntrl();
      Get.off(const HOmeScreen());
      log("wwwwwwwwwwwwwwwwwwwwwwwwww ${id.toString()}");
     
       
    }else{
      Get.showSnackbar(const GetSnackBar(backgroundColor: Colors.red,message: 'Login Failed',));
    }

    
  }



  sharedtocntrl()async{
  //  id=await SharedPref.sharedprefget();
     
      id = await SharedPref.sharedprefget();
      log('Stored ID: $id');
   
  }
}
