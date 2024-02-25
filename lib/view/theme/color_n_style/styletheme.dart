import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Styles{



   formDecorationStyle({required String labelText, required Icon icon}) {
    return InputDecoration(
      
      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
      border: InputBorder.none,
      fillColor: Color.fromARGB(255, 255, 255, 255),
      filled: true,
      labelText: labelText,

      labelStyle: MytextTheme.Medium14Text,
      prefixIcon: icon,

    );
  }

    formDecorationStyleWithSufix(
      {required String labelText, required Icon icon, required Widget sufix}) {
    return InputDecoration(
      border: InputBorder.none,
      fillColor: const Color.fromARGB(255, 242, 242, 242),
      filled: true,
      labelText: labelText,
      labelStyle: MytextTheme.Medium14Text,
      prefixIcon: icon,
      suffix: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: SizedBox(
          height: 15,
          width: 15,
          child: sufix),
      )
    );
  }

 
c1sSnackbar({required String Data,required bool green}){
    Get.showSnackbar( GetSnackBar(message: Data, backgroundColor: green==true?Colors.green:Colors.red,isDismissible: true,duration: Duration(seconds: 1),));
}

}