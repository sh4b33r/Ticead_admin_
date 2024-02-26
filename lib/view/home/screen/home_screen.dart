import 'dart:developer';

import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';

import 'package:admin_ticead/model/theatre_model/theatre_model.dart';

import 'package:admin_ticead/view/home/widget/theatre_card.dart';
import 'package:admin_ticead/view/login/login_screen.dart';
import 'package:admin_ticead/view/movie/widget/mv_searchbuilder.dart';
import 'package:admin_ticead/view/seat_/screen/seatscreen.dart';
import 'package:admin_ticead/view/theatre/screen/theatre_add.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

class HOmeScreen extends StatelessWidget {
   HOmeScreen({super.key});
    final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final Tcontroller = Get.put(TheatreController());
    String? id=SharedPref().sharedInstance.toString();
    return Scaffold(
      key: scaffoldkey,
      drawer: Drawer(

        backgroundColor: const Color.fromARGB(132, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
       
              ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    SharedPref.sharedprefset('false');
                    Get.offAll(const LoginScreen());
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
        leading: IconButton(
          onPressed: (){
           scaffoldkey.currentState!.openDrawer();
          },
          icon: 
          const Icon(Icons.menu),color: Colors.white,),
        title: Text(
          'Home',
          style: MytextTheme.appbarText,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
              Tcontroller.clearAllThings();
            Get.to(TheatreaddScreen());
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
    // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // sharedcheckbutton
         Visibility(
         visible: false, 
           child:   ElevatedButton(
                onPressed: () async {
                  // Get.to(const DateMainPage());
                  final value = await SharedPref.sharedprefget();
                 Get.to( SeatScreen());
              
                  log(value.toString());
                },
                child: const Icon(Icons.shape_line)),)
            // Text(controller.id.toString()),

            // GetBuilder<MovieController>(
            //   builder: (controller) {
            //     return ListView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: controller.theaters.length,
            //       itemBuilder: (context, index) {
            //         return TheatreCard(theatre: controller.theaters[index]);
            //       },
            //     );
            //   // },
            // ),
           , StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('theatre')
                  .where('admin_id', isEqualTo:id)
                  .snapshots(),
         
              //       FirebaseFirestore.instance
              // .collection('theatre')
              // .where('admin_id', isEqualTo: adminId)
              // .get()
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // or any loading indicator
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Column(
                  
                    children: [
                      SizedBox(height: 70,),
                      Center(child: Lottie.asset('asset/lottie/nodadta.json',height:250)),
                    ],
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var theaterData = snapshot.data!.docs[index].data();
                 var theatreId= snapshot.data!.docs[index].id;

                    // log(theaterId);
                    log(Tcontroller.currentTheatreID.value.toString());
                    GeoPoint geoPoint = theaterData['location'];
                    double latitude = geoPoint.latitude;
                    double longitude = geoPoint.longitude;
                    var theater = TheatreModel(
                        theatreAdminId: theaterData['admin_id'],
                        image: theaterData['image'] ?? [],
                        executive: theaterData['executive'] ?? 0,
                        premium: theaterData['premium'] ?? 0,
                        reclined: theaterData['reclined'] ?? 0,
                        normal: theaterData['normal']  ?? 0,
                        description: theaterData['description']  ?? '',
                        name: theaterData['name'] ?? '',
                        location: LatLng(latitude, longitude)
                        // Add other fields as needed
                        );

                    return TheatreCard(theatre: theater,theaterId:theatreId);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
