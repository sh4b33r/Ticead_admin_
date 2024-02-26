import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';
import 'package:admin_ticead/view/date_picker/widget/date_tabbar.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateMainPage extends StatelessWidget {
  final String theaterId;
  const DateMainPage({super.key,required this.theaterId});

  @override
  Widget build(BuildContext context) {
   final cntrl=Get.put(TImeController());
    cntrl.thatreoftimecurrent.value=theaterId;
    return  Scaffold(
 
  appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        backgroundColor: Colors.black,
        
       
        ),
    
      body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children:[

           Padding(
             padding: const EdgeInsets.fromLTRB(13,10,0,0),
             child: Text(DateFormat.yMMMd().format(DateTime.now()),style: MytextTheme.subheadigTExt,),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 13),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Today',style: MytextTheme.Medium15Text,),
                 ElevatedButton(onPressed: ()async{
                            
                    final val= await cntrl.selectTime(context);
                          if(val){
cntrl.sendDateTimedata();
                          }  
                 }, child: Text('Add Timing'))
               ],
             ),
           ),
         DateWidget(theaterId:theaterId)
          
           
          ]
      
      
      
      ),
    ),);
  }
}