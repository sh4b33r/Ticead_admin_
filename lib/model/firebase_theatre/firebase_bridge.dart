
import 'dart:io';
import 'dart:developer';

import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
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
}












// Future<List<String>> uploadXFilesToFirebase(List<XFile> files) async {
//   List<String> downloadUrls = [];

//   for (XFile file in files) {
//     try {
//       // Generate unique filename
//       String fileName = "${basenameWithoutExtension(file.path!)}_${DateTime.now().millisecondsSinceEpoch}.${extension(file.path!)}";

//       // Create reference
//       Reference ref = FirebaseStorage.instance.ref().child(fileName);

//       // Upload task with metadata
//       UploadTask uploadTask = ref.putFile(File(file.path!));
//       uploadTask.setMetadata(SettableMetadata(contentType: file.mimeType));

//       // Wait for upload and get download URL
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       // Add download URL to list
//       downloadUrls.add(downloadUrl);
//     } catch (error) {
//       print("Error uploading file: $error");
//       // Handle error (e.g., show user message, retry upload)
//     }
//   }

//   return downloadUrls;
// }