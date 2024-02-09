import 'dart:developer';

import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TheatreController extends GetxController {
  RxBool normal = true.obs;
  RxBool executive = false.obs;
  RxBool premium = false.obs;
  RxBool reclined = false.obs;
  RxList image = [].obs;
//  RxList<XFile> imageFileList = [].obs;


// =================================
// for Check Box
// ---------------------------------

  forCheckBox(RxBool seatType) {
    // log(seatType.value.toString());

    seatType.value = !seatType.value;
  }

  


// =================================
// List of Images pIcking
// ---------------------------------

  Future<void> pickImage() async {
    final selctimgsFile = await ImagePicker().pickMultiImage();
    if (selctimgsFile.isNotEmpty) {
 

      image.addAll(selctimgsFile);
       update(); 
    }
    // image.value = imgFile.path;
    log("Image List Length:${image.length}");
    // update();
  }

// =================================
// clearing Images that are pIcked
// ---------------------------------

  Future<void> clearImage(image) async {
   image.clear();
  }


  Future<void> removeImage(index) async {
    image.removeAt(index);
  }



}
