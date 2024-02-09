// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theatre/widget/common_priceform.dart';
import 'package:admin_ticead/view/theatre/widget/submit_button.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TexTFormfields extends StatelessWidget {
  TexTFormfields({super.key});
  var u;
  TextEditingController controllertext = TextEditingController();
  TextEditingController cntrlName = TextEditingController();
  TextEditingController cntrlDesc = TextEditingController();
  final controllerobj = Get.put(TheatreController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//  Textformfield  Theatre

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            // controller: cntrlName,
            decoration: InputDecoration(
                hintText: 'Theatre Name',
                hintStyle: MytextTheme.textformsText,
                border: const OutlineInputBorder()),
          ),
        ),

//  Textformfield of Description

        Padding(
          padding: const EdgeInsets.fromLTRB(21, 5, 21, 0),
          child: TextFormField(
            maxLines: null,
            controller: cntrlDesc,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Color.fromARGB(255, 247, 250, 248),
              hintText: 'Description About Theatre',
              // labelText: 'Description',
              hintStyle: MytextTheme.textformsText,
            ),
          ),
        ),

//  PickImage

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetX<TheatreController>(
            builder: (controller) {
              return Container(
                height: 150,
                width: MediaQuery.of(context).size.width / 1.5,
                // color:
                decoration: const BoxDecoration(
                  color: Color.fromARGB(22, 0, 0, 0),
                  // image: DecorationImage(image: controller.image.isNotEmpty? AssetImage('asset\image\logotiecad.png'):AssetImage('assets/image/Animation-707367816983.gif'))

                  // ? asset\image\logotiecad.png
                  // : AssetImage('assets/image/Animation-707367816983.gif'),
                ),
                child: controller.image.isEmpty
                    ? Lottie.asset(
                        'asset/lottie/Animation - 1707367816983.json')
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
                              child: Image.file(
                                File(controller.image[index].path),
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),

                // Text(controller.normal.toString())
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
        GetX<TheatreController>(builder: (controller) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: controller.normal.value,
                        onChanged: (_) {
                          controller.forCheckBox(controller.normal);
                        },

                        // activeColor: Colors.green,
                      ),
                      Text(
                        'Normal',
                        style: MytextTheme.textformsText,
                      )
                    ],
                  ),

                  // tickboxes in flutter theatre add screen  ----> Executive
                  Row(
                    children: [
                      Checkbox(
                        value: controller.executive.value,
                        // semanticLabel: 'sff',
                        onChanged: (_) {
                          controller.forCheckBox(controller.executive);
                        },

                        // activeColor: Colors.green,
                      ),
                      Text(
                        'Executive',
                        style: MytextTheme.textformsText,
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // tickboxes in flutter theatre add screen  ----> PREMIUM
                  Row(
                    children: [
                      Checkbox(
                        value: controller.premium.value,
                        // semanticLabel: 'sff',
                        onChanged: (_) {
                          controller.forCheckBox(controller.premium);
                        },

                        // activeColor: Colors.green,
                      ),
                      Text(
                        'Premium',
                        style: MytextTheme.textformsText,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: controller.reclined.value,
                        semanticLabel: 'sff',
                        onChanged: (_) {
                          controller.forCheckBox(controller.reclined);
                        },

                        // activeColor: Colors.green,
                      ),
                      Text(
                        'Recliner',
                        style: MytextTheme.textformsText,
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Custom price TEXTFIELD for NORMAL

            controller.normal.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(hintText: 'Normal'))
                : const SizedBox(),

            // Custom price TEXTFIELD for EXECUTIVE

            controller.executive.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(hintText: 'Executive'))
                : const SizedBox(),

            // Custom price TEXTFIELD for PREMIUM

            controller.premium.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(
                      hintText: 'Premium',
                    ))
                : const SizedBox(),

            // Custom price TEXTFIELD for RECLINED

            controller.reclined.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(hintText: 'Recliner'))
                : const SizedBox(),

            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Location'),
                        Icon(Icons.location_on_rounded)
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            // submiTButton(TheatreModel(name: cntrlName.text, description: cntrlDesc.text, image: controller.image.value, normal: controller.normal.value, executive: controller.executive.value, premium: controller.premium.value, reclined: controller.premium.value))
            submiTButton(TheatreModel(
              name: cntrlName.text,
              description: cntrlDesc.text,
              image: '',
              normal: controller.normal.value,
              executive: controller.executive.value,
              premium: controller.premium.value,
              reclined: controller.reclined.value,
            ))
          ]);
        })
      ],
    );
  }
}
