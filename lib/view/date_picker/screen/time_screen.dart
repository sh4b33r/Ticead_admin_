import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';
import 'package:admin_ticead/view/date_picker/widget/date_tabbar.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateMainPage extends StatelessWidget {
  const DateMainPage({super.key});

  @override
  Widget build(BuildContext context) {
   final cntrl=Get.put(TImeController());
   
    return  Scaffold(
 
    
      body: SingleChildScrollView(
      child: Column(
          
        children:[
           Text(DateFormat.yMMMd().format(DateTime.now()),style: MytextTheme.Medium14Text,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 13),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Today',style: MytextTheme.Medium15Text,),
                 ElevatedButton(onPressed: ()async{
                            
                     await cntrl.selectTime(context);
                            cntrl.sendDateTimedata();
                 }, child: Text('Add Timing'))
               ],
             ),
           ),
         DateWidget()
          
           
          ]
      
      
      
      ),
    ),);
  }
}