// import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class TextsFieldsCustom extends StatelessWidget {
//   const TextsFieldsCustom({super.key});

//   @override
//   Widget build(BuildContext context) {
//           TextEditingController cntrlName = TextEditingController();
//   TextEditingController cntrlDesc = TextEditingController();
//     return Column(children: [//  Textformfield  Theatre

//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: TextFormField(
//             controller: cntrlName,
//             decoration: InputDecoration(
//                 hintText: 'Theatre Name',
//                 hintStyle: MytextTheme.textformsText,
//                 border: const OutlineInputBorder()),
//           ),
//         ),

// //  Textformfield of Description

//         Padding(
//           padding: const EdgeInsets.fromLTRB(21, 5, 21, 0),
//           child: TextFormField(
//             maxLines: null,
//             controller: cntrlDesc,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                   borderSide: BorderSide.none),
//               filled: true,
//               fillColor: Color.fromARGB(255, 247, 250, 248),
//               hintText: 'Description About Theatre',
//               // labelText: 'Description',
//               hintStyle: MytextTheme.textformsText,
//             ),
//           ),
//         ),
// ],);
//   }
// }

// ==================================
// firstTwotextfields
// ----------------------------------

import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';

textfields(TextEditingController cntrlName,TextEditingController cntrlDesc,){
  return  Column(children: [//  Textformfield  Theatre

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: cntrlName,
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
],);
}