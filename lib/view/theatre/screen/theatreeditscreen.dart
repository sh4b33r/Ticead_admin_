import 'package:admin_ticead/controller/theatre_controller/edit_theatre.controller.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theatre/widget/texts_field.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class TheatreEditscreen extends StatelessWidget {
  final TheatreId;
  const TheatreEditscreen({super.key, this.TheatreId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TheatreEditcontroller());

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 226, 252, 222),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 4,
                      offset: Offset(1, 2),
                      blurRadius: 15)
                ],
              ),
              child: Column(
                children: [
                  textfields(controller.cntrlName, controller.cntrlDesc),
                  //  textfields(controller.cntrlName, controller.cntrlDesc),
                  // TextsFieldsCustom(),
                  //]
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width / 1.5,
                    // color:
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(22, 0, 0, 0),
                    ),
                    child: controller.Images.isEmpty
                        ? Lottie.asset(
                            'asset/lottie/Animation - 1707367816983.json')
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.Images.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onDoubleTap: () {
                                  // controller.removeImage(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Image.network(
                                      controller.Images[index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                    // Text(controller.normal.toString())
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () async {
                        // await controller.pickImage();
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Pick Image')),
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
                            // ====================================
                            final value = TheatreModel(
                                theatreAdminId:
                                    SharedPref().sharedInstance.toString(),
                                name: controller.cntrlName.text,
                                description: controller.cntrlDesc.text,
                                image: controller.Images,
                                normal: controller.normal.value,
                                executive: controller.executive.value,
                                premium: controller.premium.value,
                                reclined: controller.reclined.value,
                                location: LatLng(24.4, 24.4));
                            // controller.toedit(value);
                            controller.cntrlName.clear();
                            controller.cntrlDesc.clear();
                            // controller.cntrlDesc.clear();
                            Get.back();
                            // ===================================================
                          },
                          child: Text(
                            'Submit',
                            style: MytextTheme.commomText,
                          )),
                    ),
                  )
                ],
              ),
            ),
            const Positioned(
                right: -21,
                top: 140,
                child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 237, 252, 222))),
            // Image.asset(
            //   'asset/image/Vector_10.png',
            // ),
            Positioned(
                right: 0,
                child: Image.asset(
                  'asset/image/sibgezigaga.png',
                )),
            const Positioned(
                left: -21,
                top: 140,
                child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 237, 252, 222))),
          ]),
        ),
      ),
    );
  }
}
