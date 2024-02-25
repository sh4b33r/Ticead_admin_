import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/view/theatre/widget/text_formcustom.dart';
import 'package:admin_ticead/view/theatre/widget/texts_field.dart';
import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheatreaddScreen extends StatelessWidget {
  bool isEditing; 
  TheatreaddScreen({super.key,this.isEditing=false});
 
  final controller = Get.put(TheatreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(onPressed: (){

          Get.back();
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),

        backgroundColor: const Color.fromARGB(235, 0, 0, 0)),
      backgroundColor: MycolorTheme.custwhite,
      body: Padding(
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
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                   isEditing?textfields(controller.cntrlName, controller.cntrlDesc,isEditing: isEditing):
                    textfields(controller.cntrlName, controller.cntrlDesc,),
                    // TextsFieldsCustom(),
                    //  isEditing?
                     TexTFormfields(isEditing: isEditing,)
                    // TexTFormfields(),
                  ],
                ),
              ),
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
    );
  }
}
