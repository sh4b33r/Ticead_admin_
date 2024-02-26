// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../../theme/text_theme/main_texts.dart';

import 'dart:developer';

class CustomFormPriceField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;

  CustomFormPriceField({Key? key, required this.hintText,  this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     log(hintText.toString());
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
           decoration: InputDecoration(
                
                    hintText: hintText,
                    hintStyle: MytextTheme.textformsText,
                    border: const OutlineInputBorder()
                    ),
          
          
          );
  }
}