import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      final  email = val.user!.email;
      final name = val.user!.displayName;

      // print('............>>>>>>>>>>>>>>>>>>>${val.credential!.accessToken}');
      log(email.toString());
      return {'email': email, 'name': name};
    }
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
