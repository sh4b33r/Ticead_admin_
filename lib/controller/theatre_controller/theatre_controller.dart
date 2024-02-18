import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TheatreController extends GetxController {
  RxBool normal = true.obs;
  RxBool executive = false.obs;

  RxBool premium = false.obs;
  RxBool reclined = false.obs;
  RxList<XFile> image = <XFile>[].obs;
  List<String> names = [];
  TextEditingController cntrlName = TextEditingController();
  TextEditingController cntrlDesc = TextEditingController();
  TextEditingController? cntrlNormal = TextEditingController();
  TextEditingController? cntrlExecutive = TextEditingController();
  TextEditingController? cntrlPremium = TextEditingController();
  TextEditingController? cntrlreclined = TextEditingController();

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
      for (var slctdsingle in selctimgsFile) {
        String toconvert = slctdsingle.name;
         log(names.toString());

        if (!names.contains(toconvert)) {
          image.add(slctdsingle);          update();
          names.add(toconvert);
        }
      }
    } else {
      log('no');
    }
    // image.value = imgFile.path;
     log(names.toString());
    log("Image List Length:${image.length}");
    // update();
  }

// =================================
// clearing Images that are pIcked
// ---------------------------------

  Future<void> clearImage(image) async {
    image.clear();
    update();
  }

  Future<void> removeImage(int index) async {
//  log(imageofxfile.path);
//     int nameindex = image.indexOf(imageofxfile.name);
//     log('nameindex   $nameindex');
//     int index = image.indexOf(imageofxfile);
//     log('nameindex   $index');

    image.removeAt(index);
    names.removeAt(index);
    update();
  }



// =================================
// clearing Images that are pIcked
// ---------------------------------
  clearAllThings() {
    cntrlName.clear();
    cntrlDesc.clear();
    cntrlNormal?.clear();
    cntrlExecutive?.clear();
    cntrlPremium?.clear();
    cntrlreclined?.clear();
    image.clear();
    update();
  }
}
