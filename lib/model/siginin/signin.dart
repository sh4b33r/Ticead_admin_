import 'dart:developer';

import 'package:admin_ticead/model/firebase_theatre/firebase_bridge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared_pref/shared_funcitons.dart';

// =========================
// for google sigin
// -------------------------

signInwithgoogle() async {
  log('etheektoo');
  // final googlesignIn = GoogleSignIn().signIn();
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final val = await FirebaseAuth.instance.signInWithCredential(credential);
      final email = val.user!.email;
      final name = val.user!.displayName;

      // print('............>>>>>>>>>>>>>>>>>>>${val.credential!.accessToken}');
      log("email from siginin ${email.toString()}");
      log("NAme from siginin ${name.toString()}");

      return {'email': email, 'name': name};
    }
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

// ==================================
// for firbaseFirestore storing sigin in Creds
// ----------------------------------

Future<String> addUser(String? email, String? name) async {
  final fdata = await FirebaseFirestore.instance
      .collection('theatre_admin')
      .where('email', isEqualTo: email)
      .get();

  log(" .................................${fdata.docs.isEmpty}.......................................");

  if (fdata.docs.isEmpty) {
    final id =
        await FirebaseFirestore.instance.collection('theatre_admin').add({
      'email': email,
      'name': name,
      'theatreIds': [],
      'timestamp': FieldValue.serverTimestamp(),
    });

   

    return id.id;
  } else {
    String existingUserId = fdata.docs.first.id;
    return existingUserId;
  }
}


// updte theatre id with admin

Future<void> updatetheatrewithidstoadmin(String theatreId)async{
 log("ivide ethiiikin ${SharedPref().sharedInstance.toString()}");
 await FirebaseFirestore.instance.collection('theatre_admin').doc(SharedPref().sharedInstance.toString()).update({'theatreIds':FieldValue.arrayUnion([theatreId])});

} 



// Future<List<DocumentSnapshot>> getTheatersForAdmin(String? adminId) async {
//   QuerySnapshot theatersSnapshot = await FirebaseFirestore.instance
//       .collection('theatre')
//       .where('admin_id', isEqualTo: adminId)
//       .get();

//   return theatersSnapshot.docs;
// }