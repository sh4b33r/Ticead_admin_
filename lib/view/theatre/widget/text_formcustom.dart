// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:developer';

import 'package:admin_ticead/controller/map_controller/gmap_controller.dart';
import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/firebase_theatre/firebase_bridge.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';

import 'package:admin_ticead/view/theatre/widget/seat_seelct_ticks.dart';
import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../model/theatre_model/theatre_model.dart';
import '../../gmap/g_map.dart';

class TexTFormfields extends StatelessWidget {
 
 final bool isEditing;
   TexTFormfields({super.key,this.isEditing=false});
  // var u;
  TextEditingController controllertext = TextEditingController();

  final controllerobj = Get.find<TheatreController>();
  final gcontroller = Get.put(GMapController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
//  PickImage
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<TheatreController>(
          builder: (controller) {
            return Column(
              children: [
//  Align(
//   alignment: Alignment.topLeft,
//    child: Visibility(
//                       visible: controllerobj.ImageNotpicked.value,
//                       child: Text('Please Select Image')),
//  ),

Container(
  height: 150,
  width: MediaQuery.of(context).size.width / 1.5,
  decoration: BoxDecoration(
    color: const Color.fromARGB(22, 0, 0, 0),
  ),
  child: controller.image.isEmpty
      ? (isEditing
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controllerobj.imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image.network(
                       controllerobj.imageUrls[index],
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            )
          : Lottie.asset('asset/lottie/Animation - 1707367816983.json'))
      : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.image.length,
          itemBuilder: (context, index) {
            return InkWell(
              onDoubleTap: () {
                controller.removeImage(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.file(
                    File(controller.image[index].path),
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
),

// ----------------------------------------------first conaitainer===========----------------------------
                // Container(
                //   height: 150,
                //   width: MediaQuery.of(context).size.width / 1.5,
                //   // color:
                //   decoration: const BoxDecoration(
                //     color: Color.fromARGB(22, 0, 0, 0),
                //   ),
                //   child: controller.image.isEmpty
                //       ? Lottie.asset(
                //           'asset/lottie/Animation - 1707367816983.json')
                //       : ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: controller.image.length,
                //           itemBuilder: (context, index) {
                //             return InkWell(
                //               onDoubleTap: () {
                //                 controller.removeImage(index);
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Container(
                //                   child: Image.file(
                //                     File(controller.image[index].path),
                //                     height: 100,
                //                     width: 100,
                //                     fit: BoxFit.contain,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),

                //   // Text(controller.normal.toString())
                // ),

   // ----------------------------------------------first conaitainer===========----------------------------
              ],
            );
          },
        ),
      ),

      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () async {
            await controllerobj.pickImage();
          },
          icon: const Icon(Icons.camera_alt_outlined),
          label: const Text('Pick Image')),

      const SizedBox(
        height: 7,
      ),
      Text(
        'Please Select the below Category :',
        style: MytextTheme.textformsText,
      ),
      const SizedBox(
        height: 7,
      ),

// tickboxes in flutter theatre add screen  ----> Normal

      const SeatSelection(),

      const SizedBox(
        height: 7,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: () {
            // Get.to(GMap());
            Get.to(GMapPage());
          },
          child: Container(
            height: 30,
            decoration: const BoxDecoration(
              color: MycolorTheme.custwhite,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    gcontroller.latLng == const LatLng(11.258753, 75.780411)
                        ? const Text('Location')
                        : GetX<GMapController>(
                            builder: (controller) {
                              return Text(
                                controller.latLng.value
                                    .toString()
                                    .substring(0, 28),
                              );
                            },
                          ),
                    const Icon(Icons.location_on_rounded)
                  ]),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      //     // submiTButton(TheatreModel(name: cntrlName.text, description: cntrlDesc.text, image: controller.image.value, normal: controller.normal.value, executive: controller.executive.value, premium: controller.premium.value, reclined: controller.premium.value))
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 38.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 87, 196, 150),
                Color.fromARGB(255, 48, 163, 77),
                Color.fromARGB(255, 10, 146, 44),
              ])),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () async {
                final urls = await FirebaseService.imgsendingtoFStorage(
                    controllerobj.image);
                log('all urls  textformcutom_141>>>>>> $urls');
                log(controllerobj.cntrlNormal?.text as String);
                if (controllerobj.image.isEmpty) {
                  Styles().c1sSnackbar(
                      Data: "Can't Leave Image Empty ", green: false);
                }

                if (controllerobj.formKey.currentState!.validate() &&
                    controllerobj.image.isNotEmpty) {
                  await FirebaseService.sendDatatoFirebase(TheatreModel(
                    theatreAdminId: SharedPref().sharedInstance.toString(),
                    name: controllerobj.cntrlName.text,
                    description: controllerobj.cntrlDesc.text,
                    image: urls,
                    normal: controllerobj.normal.value,
                    executive: controllerobj.executive.value,
                    premium: controllerobj.premium.value,
                    reclined: controllerobj.reclined.value,
                    location: gcontroller.latLng.value,
                    reclinedprice: controllerobj.cntrlreclined?.text ?? '0',
                    executiveprice: controllerobj.cntrlExecutive?.text ?? '0',
                    normalprice: controllerobj.cntrlNormal?.text ?? '0',
                    premiumprice: controllerobj.cntrlPremium?.text ?? '0',
                  ));
                  // updatetheatrewithidstoadmin();

                  controllerobj.clearAllThings();
                }

                //  return
              },
              child: Text(
                'Submit',
                style: MytextTheme.commomText,
              )),
        ),
      )
      //   ]);
      // })
    ]);
  }
}
