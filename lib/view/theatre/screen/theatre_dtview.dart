import 'dart:developer';
import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';
import 'package:admin_ticead/view/theatre/screen/theatre_add.dart';

import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheatreDetailedView extends StatelessWidget {
  final TheatreModel theatre;
  final String currrntheatreId;
  const TheatreDetailedView({super.key,required this.theatre,required this.currrntheatreId});

  @override
  Widget build(BuildContext context) {
//  final TheatreEditcontroller editTcontroller =   Get.put(TheatreEditcontroller());
 final  Tcontroller =   Get.put(TheatreController());
 Tcontroller.currentTheatreID.value=currrntheatreId;
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        backgroundColor: Colors.black,
        
        actions: [
          
          IconButton(onPressed: ()async{
          final data= await FirebaseFirestore.instance.collection('theatre').doc(currrntheatreId).get() ;
          // editTcontroller.editTheatreModal(data.data()) ;
          // await editTcontroller.tocontrolelr();
          log("${data.data()}");

    
  
             Tcontroller.assignvalues(data.data());

          // Get.to(TheatreEditscreen( ));
          Get.to(TheatreaddScreen(isEditing: true,));


// to !!EDIT!! 1 Edit Screen with first thing to do  
     
          // Get.to(TheatreaddScreen(isEditing: true));
        }, icon: Icon(Icons.edit,color: MycolorTheme.custwhite,))],
        ),
           
   body: StreamBuilder(
    stream:FirebaseFirestore.instance.collection('theatre').doc(Tcontroller.currentTheatreID.value).snapshots() ,
    builder: (context, snapshot) {
      if(snapshot.hasData){
           var data = snapshot.data!.data() as Map<dynamic,dynamic>;
 return ListView(
     children: [
       SizedBox(height: 10),
     CarouselSlider(
        items: [
          for (int i = 0; i < data['image'].length; i++)
            Container(
              child: Image.network(data['image'][i],fit: BoxFit.contain,
              // errorBuilder: (context, error, stackTrace) {
                
              // },
              ) ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: DecorationImage(
                    //   image: 
                    //       NetworkImage(data['image'][i] 
                           
                    //     ) ?? ,
                    //   fit: BoxFit.cover,
                    // ),
                    
                  ),
                  alignment: Alignment.center, 
                ),
            
        ],
        options: CarouselOptions(
             pageSnapping: true,
            viewportFraction: .83,
            height: 250,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3)),
      )
      
     ,
      
        
        // stream: FirebaseFirestore.instance.collection('theatre').doc(Tcontroller.currentTheatreID.value).snapshots()  ,
     
        // builder: (context, snapshot) {
         
        // if(snapshot.hasData && snapshot.data!=null){
        // var data = snapshot.data!.data() as Map<dynamic,dynamic>;
        // log(data['name']as String);
     
     
       Padding(
          padding: const EdgeInsets.fromLTRB(15,15,10,0),
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['name'] ?? '',style: MytextTheme.headingText,),
              Text(data['description'] ?? '',style:MytextTheme.Medium15Text ,)
            ],
          ),
        )
      
     
     
 
     
        // },
       
      
     
     
     
     ],
     
     
     
     
     );
      }else{

        
      }
 return Center(child: CircularProgressIndicator());


    },
  
   ),



    );
  }
}