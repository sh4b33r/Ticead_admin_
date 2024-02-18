import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

tabView(){
  
 final cntrl=Get.find<TImeController>();
return Expanded(child: Obx((){

return ListView.builder(
  itemCount:cntrl.moviepage.length ,
  itemBuilder:(context, index) {
  return Container(color: Colors.red,
  
  
  height: 300,

  );



},);

}));



}