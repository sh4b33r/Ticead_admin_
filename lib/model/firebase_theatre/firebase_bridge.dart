import 'dart:developer';

import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        'name': theatre.name,
        'description': theatre.description,
        'image': theatre.image,
        'normal': theatre.normal,
        'executive': theatre.executive,
        'reclined': theatre.reclined,
        'premium': theatre.premium,
      });

      log('Document added with ID: ${a.id}');
    } catch (e) {
      log('Error adding document: $e');
    }
  }



// ==================================-=============
// Sending image That are picked to Firbase Storage
// ------------------------------------------------




}