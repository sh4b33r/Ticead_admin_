import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/view/theatre/widget/common_priceform.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class SeatSelection extends StatelessWidget {
  const SeatSelection({super.key});
 
  @override
  Widget build(BuildContext context) {
    Get.find<TheatreController>();
    return    GetX<TheatreController>(builder: (controller) {
        return Column(
          children: [
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
                        'Normal Price',
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
                        'Executive Price',
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
                        'Premium Price',
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
                        'Recliner Price',
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
                    child: CustomFormPriceField( controller: controller.cntrlNormal, hintText: 'Normal'))
                : const SizedBox(),
        
            // Custom price TEXTFIELD for EXECUTIVE
        
            controller.executive.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField( controller: controller.cntrlExecutive, hintText: 'Executive'))
                : const SizedBox(),
        
            // Custom price TEXTFIELD for PREMIUM
        
            controller.premium.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(
                      controller: controller.cntrlPremium, 
                      hintText: 'Premium',
                    ))
                : const SizedBox(),
        
            // Custom price TEXTFIELD for RECLINED
        
            controller.reclined.value == true
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: CustomFormPriceField(controller: controller.cntrlreclined, hintText: 'Recliner'))
                : const SizedBox(),
          ],
        );
      });
  }
}