import 'package:admin_ticead/view/theatre/screen/theatre_add.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HOmeScreen extends StatelessWidget {
  const HOmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
 title:  Text('Home',style: MytextTheme.appbarText,),
        backgroundColor: Colors.amber,
      )
      ,
      floatingActionButton:FloatingActionButton(
        
        onPressed: (){


  Get.to(TheatreaddScreen());

        },
      child: const Icon(Icons.add)),
body: const SingleChildScrollView(
  
physics: NeverScrollableScrollPhysics(),
child: Column(children: [


],),


),



    );
  }
}