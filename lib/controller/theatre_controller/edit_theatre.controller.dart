import 'dart:developer';

import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class TheatreEditcontroller extends GetxController {
  RxBool normal = true.obs;
  RxBool executive = false.obs;
  RxBool imageNotpicked = false.obs;

  RxBool premium = false.obs;
  RxBool reclined = false.obs;
  RxList<dynamic> Images = <dynamic>[].obs;
  List<String> names = [];
  TextEditingController cntrlName = TextEditingController();
  TextEditingController cntrlDesc = TextEditingController();
  TextEditingController? cntrlNormal = TextEditingController();
  TextEditingController? cntrlExecutive = TextEditingController();
  TextEditingController? cntrlPremium = TextEditingController();
  TextEditingController? cntrlreclined = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TheatreModel? edittheatre;

  Future<void> editTheatreModal(Map<String, dynamic>? val) async {
    log("${val!["name"]}");
    edittheatre = TheatreModel(
        theatreAdminId: val["admin_id"],
        name: val["name"],
        description: val["description"],
        image:  val["image"],
        normal: val["normal"],
        executive: val["executive"],
        premium: val["premium"],
        reclined: val["reclined"],
        location: const LatLng(45, 110),
        executiveprice: "0",
        normalprice: "0",
        reclinedprice: "0",
        premiumprice: "0");
    // log("${edittheatre?.name}");
  }


  Future<void> tocontrolelr() async {
    cntrlName.text=edittheatre!.name;
    cntrlDesc.text=edittheatre!.description;
     log("=======================${Images.runtimeType}");
      // for(var ele in edittheatre!.image)
      // {
      //   image.add(ele);
      // }
      Images.value.addAll(edittheatre!.image );
     
  }


  
  

  void deleteTheatre(String thId) async {
    try {
      await FirebaseFirestore.instance.collection('theatre').doc(thId).delete();
      Styles().c1sSnackbar(Data:'Theatre deleted successfully' , green: true);
      
    } catch (e) {
     log(e.toString());
     
    }
  }
}

