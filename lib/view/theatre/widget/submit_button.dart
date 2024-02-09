import 'dart:developer';

import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/text_theme/main_texts.dart';
Widget submiTButton(TheatreModel theatreModel) {
    log(theatreModel.name);
  var cntrl=Get.find<TheatreController>();
  return Container(
    height: 38.0,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(colors: [

          Color.fromARGB(255, 87, 196, 150),
          Color.fromARGB(255, 48, 163, 77),
          Color.fromARGB(255, 10, 146, 44),

        ])),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: ()async{
       
        // await  cntrl.sendDatatoFirebase(theatreModel);
        
              //  return
        },
        child: Text(
          'Submit',
          style: MytextTheme.commomText,
        )),
  );
}
