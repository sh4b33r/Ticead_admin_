import 'dart:developer';

import 'package:admin_ticead/controller/login_controller/login_controller.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';
import 'package:admin_ticead/view/date_picker/screen/time_screen.dart';
import 'package:admin_ticead/view/login/login_screen.dart';
import 'package:admin_ticead/view/theatre/screen/theatre_add.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HOmeScreen extends StatelessWidget {
  const HOmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? id;
    final controller = Get.put(LoginController());
    return Scaffold(
      drawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    SharedPref.sharedprefset('false');
                    Get.offAll(LoginScreen());
                    Get.showSnackbar(const GetSnackBar(
                      message: 'Logged out  Succesfully',
                      snackStyle: SnackStyle.FLOATING,
                      duration: Duration(seconds: 2),
                    ));
                  },
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Logout'))
            ],
          )),
      appBar: AppBar(
        title: Text(
          'Home',
          style: MytextTheme.appbarText,
        ),
        backgroundColor: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(TheatreaddScreen());
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // sharedcheckbutton
            ElevatedButton(
                onPressed: () async {



                  Get.to(DateMainPage());
                  final value = await SharedPref.sharedprefget();
                  id = await SharedPref.sharedprefget();
                  log(value.toString());
                },
                child: const Icon(Icons.shape_line)),
            Text(controller.id.toString()),
          ],
        ),
      ),
    );
  }
}
