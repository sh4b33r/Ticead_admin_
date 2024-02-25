
import 'dart:io';
import 'dart:developer';

import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/siginin/signin.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../shared_pref/shared_funcitons.dart';

class FirebaseService {
  final controller=Get.find<TheatreController>();
// =================================
// Adding USer Auhtenticating
// ---------------------------------'

// addUSer(){ FirebaseFirestore.instance.collection('user').add({
//         'email': email,
//         'name':name,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

// }

// =================================
// sending theatre data to FBase
// ---------------------------------

  static sendDatatoFirebase(TheatreModel theatre) async {
    log('reachde to this function');
    log(theatre.name);
    log(theatre.description);
    // log(theatre.image);
    // log(theatre.reclined.toString());
    // log(theatre.normal.toString());
    // log(theatre.executive.toString());
    // log(theatre.premium.toString());
  
    try {
  

      final a = await FirebaseFirestore.instance.collection('theatre').add({
        'admin_id':theatre.theatreAdminId,
        'name': theatre.name,
        'description': theatre.description,
        'image': theatre.image,
        'normal': theatre.normal,
        'executive': theatre.executive,
        'reclined': theatre.reclined,
        'premium': theatre.premium,
        'location':GeoPoint( theatre.location.latitude, theatre.location.longitude),
        'normal_Price':theatre.normalprice,
        'premium_Price':theatre.premiumprice,
        'executive_Price':theatre.executiveprice,
        'reclined_Price':theatre.reclinedprice,
      });

      log('Document added with ID: ${a.id}');
       Styles().c1sSnackbar(
                      Data: "Data Added Succesfully ", green: true);
                      // log('sharedinstance :${sharedInstance as String}');
                      log(SharedPref().sharedInstance.toString());
     await updatetheatrewithidstoadmin(a.id);
    } catch (e) {
      log('Error adding document: $e');

      Get.rawSnackbar(
          backgroundColor: Colors.red,
          message: 'error while sending Data to firebase $e',
          snackStyle: SnackStyle.FLOATING);
    }
  }

// ==================================-===========================
// Sending image That are picked by imagepicker to Firbase Storage
// --------------------------------------------------------------

 static Future<List<String>> imgsendingtoFStorage(List<XFile> imagexfile) async {
  
    List<String> downloadUrls = [];
    
    // final name=Datetime.now
    tosendandgeturl(file) async {
      final storageRef = FirebaseStorage.instance.ref();
      String name=DateTime.now().toString();
      String fileName = "theatreimage/$name.jpg";
      Reference refernece = storageRef.child(fileName);
      TaskSnapshot upload =await refernece.putFile(File(file.path!));
        
        
      String url = await upload.ref.getDownloadURL();

      return url;
    }


  for(XFile file in imagexfile){
  
   final data = await tosendandgeturl(file);
   downloadUrls.add(data);
  
   }
  return downloadUrls;
  }





// =================================
// EDitig theatre Data from Firebase
// ---------------------------------



toeditFromFBase(TheatreModel theatre)async{
await FirebaseFirestore.instance.collection('theatre').doc(controller.TheatreId.toString()).update({

 'admin_id':theatre.theatreAdminId,
        'name': theatre.name,
        'description': theatre.description,
        'image': theatre.image,
        'normal': theatre.normal,
        'executive': theatre.executive,
        'reclined': theatre.reclined,
        'premium': theatre.premium,
        'location':GeoPoint( theatre.location.latitude, theatre.location.longitude),
        'normal_Price':theatre.normalprice,
        'premium_Price':theatre.premiumprice,
        'executive_Price':theatre.executiveprice,
        'reclined_Price':theatre.reclinedprice,

});
Styles().c1sSnackbar(Data: 'data Edited Succesully',green: true);

}



}

