import 'dart:developer';
import 'package:admin_ticead/controller/map_controller/gmap_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class TheatreController extends GetxController {
  Rx<String> currentTheatreID=''.obs;
  RxBool normal = true.obs;
  RxBool executive = false.obs;
  RxBool ImageNotpicked=false.obs;
  String? TheatreId ;
  RxBool premium = false.obs;
  RxBool reclined = false.obs;
  RxList<XFile> image = <XFile>[].obs;
  List<String> names = [];
  RxList<String> imageUrls= <String>[].obs;
  TextEditingController cntrlName = TextEditingController();
  TextEditingController cntrlDesc = TextEditingController();
  TextEditingController? cntrlNormal = TextEditingController();
  TextEditingController? cntrlExecutive = TextEditingController();
  TextEditingController? cntrlPremium = TextEditingController();
  TextEditingController? cntrlreclined = TextEditingController();
  final formKey = GlobalKey<FormState>();
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

  Future<void> clearImage() async {
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

// =================================
// DELETING THEATRE WITH ID
// ---------------------------------

  void deleteTheatre(String thId) async {
    try {
      await FirebaseFirestore.instance.collection('theatre').doc(thId).delete().then((value) {



           Styles().c1sSnackbar(Data:'Theatre deleted successfully' , green: true);
      } );
   
      
    } catch (e) {
     log(e.toString());
     
    }
  }



  
// =================================
// ASSIGNING THINGS FOR EDITITNG
// ---------------------------------

Future<void> assignvalues(Map<String, dynamic>? val,)async{
 
    final theatre= TheatreModel(
        theatreAdminId: val!["admin_id"],
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
       


 log('keeeri');
 log( val["name"]);
 log(theatre.description)
; cntrlName.text= theatre.name;
 cntrlDesc.text=theatre.description;
//  image.value=theatre.image as List<XFile>;
//  image.value=(val!["image"] as List<String>).map((url) => XFile(url)).toList();
 imageUrls.value=
     List<String>.from(val["image"]);
  
 cntrlNormal?.text='0';
 cntrlExecutive?.text='0';
 cntrlPremium?.text="0";
 cntrlreclined?.text="0";
 normal.value=theatre.normal;
 executive.value= theatre.executive;
 premium.value=theatre.premium;
 Get.find<GMapController>().latLng.value=LatLng(10.3434, 76.5475);
 reclined.value=theatre.reclined ;

  
    
  // Future<void> editTheatreModal(Map<String, dynamic>? val) 
  //   log("${val!["name"]}");
  //   edittheatre = TheatreModel(
  //       theatreAdminId: val["admin_id"],
  //       name: val["name"],
  //       description: val["description"],
  //       image:  val["image"],
  //       normal: val["normal"],
  //       executive: val["executive"],
  //       premium: val["premium"],
  //       reclined: val["reclined"],
  //       location: const LatLng(45, 110),
  //       executiveprice: "0",
  //       normalprice: "0",
  //       reclinedprice: "0",
  //       premiumprice: "0");
    // log("${edittheatre?.name}");

  }




 }

  

