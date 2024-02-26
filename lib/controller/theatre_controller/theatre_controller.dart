import 'dart:developer';
import 'package:admin_ticead/controller/map_controller/gmap_controller.dart';
import 'package:admin_ticead/model/firebase_theatre/firebase_bridge.dart';
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
  RxBool isloadingImg=false.obs;
  RxBool ImageNotpicked=false.obs;
  String? TheatreId ;
  RxBool premium = false.obs;
  RxBool reclined = false.obs;
  Rx<LatLng> editedlocation=LatLng(11.0510,76.056).obs;
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
  RxBool isEditingImages = false.obs;
  dynamic submit=Text('Submit').obs;
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

Future<void> pickImage(bool isEditing) async {
try {
  final selctimgsFile = await ImagePicker().pickMultiImage();
  isloadingImg.value = true;
    update(); 
  if (selctimgsFile.isNotEmpty) {
    for (var slctdsingle in selctimgsFile) {
      String toconvert = slctdsingle.name;
      log(names.toString());

      // if (!names.contains(toconvert)) {
  
        String downloadUrl = await FirebaseService.imgsendingtoFStorage(slctdsingle);

        image.add(slctdsingle);

        imageUrls.add(downloadUrl);
        log('scucess $downloadUrl');

        // Update the UI
        update();

        // names.add(toconvert);
      // }
    }
  } else {
    log('no');
  }
} finally {
   isloadingImg.value = false;
    update(); 
}
 
}
// ---------------------------------------
// delete image from update screen 
// ========================================

editedImageDeleting(img)async{
   imageUrls.remove(img);
   update();

} 

// =================================
// clearing Images that are pIcked
// ---------------------------------

  Future<void> clearImage() async {
    imageUrls.clear();
    update();
  }

  Future<void> removeImage(int index) async {
//  log(imageofxfile.path);
//     int nameindex = image.indexOf(imageofxfile.name);
//     log('nameindex   $nameindex');
//     int index = image.indexOf(imageofxfile);
//     log('nameindex   $index');

    image.removeAt(index);
    imageUrls.removeAt(index);
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

    imageUrls.clear();
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
  GeoPoint gpoint =val!['location'];
  LatLng points=LatLng(gpoint.latitude,gpoint.longitude);
    final theatre= TheatreModel(
        theatreAdminId: val!["admin_id"],
        name: val["name"],
        description: val["description"],
        image:  val["image"],
        normal: val["normal"],
        executive: val["executive"],
        premium: val["premium"],
        reclined: val["reclined"],
        location: points,
        executiveprice: val["executive_Price"],
        normalprice: val["normal_Price"],
        reclinedprice: val["reclined_Price"],
        premiumprice: val["premium_Price"]);
       


 log('keeeri');
 log( val["name"]);
 log(theatre.description)
; cntrlName.text= theatre.name;
 cntrlDesc.text=theatre.description;
//  image.value=theatre.image as List<XFile>;
//  image.value=(val!["image"] as List<String>).map((url) => XFile(url)).toList();
 imageUrls.value=
     List<String>.from(val["image"]);
  log("before    ${editedlocation.value.toString()}");
   if (val["location"] != null) {
     GeoPoint geoPoint = val["location"] as GeoPoint;
    double latitude = geoPoint.latitude;
    double longitude = geoPoint.longitude;
    

    editedlocation.value =  
   LatLng(latitude, longitude);
  }
log("after     ${editedlocation.value.toString()}");



 cntrlNormal?.text=theatre.normalprice ?? '0';
 cntrlExecutive?.text= theatre.executiveprice ??'0';
 cntrlPremium?.text=theatre.premiumprice ?? "0";
 cntrlreclined?.text=theatre.reclinedprice ?? "0";
 normal.value=theatre.normal;
 executive.value= theatre.executive;
 premium.value=theatre.premium;
//  editedlocation.value=LatLng(11.0510,11.0510);4
Get.put(GMapController()).latLng.value=editedlocation.value ?? LatLng(11.0510, 76.0711);
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

  

