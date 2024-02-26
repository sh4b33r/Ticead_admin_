
import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/theatre_model/theatre_model.dart';

import 'package:admin_ticead/view/theatre/screen/theatre_dtview.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../date_picker/screen/time_screen.dart';

class TheatreCard extends StatelessWidget {
  final TheatreModel theatre;
  final String theaterId;
  
 TheatreCard({super.key, required this.theatre,required this.theaterId});

final controller= Get.find<TheatreController>();

  @override
  Widget build(BuildContext context) {
  

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(

        children: [
          InkWell(
    onTap: () {
     Get.to(TheatreDetailedView(theatre: theatre,currrntheatreId:theaterId));
    },

    onDoubleTap: (){
Styles().showAlertDialog(context,theaterId);
      // Get.put(TheatreEditcontroller()).deleteTheatre(theaterId);
     
    },
            child: Card(
              color: Color.fromARGB(255, 201, 242, 211),
              child: Container(
                
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage('asset/image/samll ticket.png'),fit: BoxFit.contain
                  
                  // ),
              
                 border: Border.all(style: BorderStyle.none),
                 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    //  Container(
                    //    child: PageView.builder(
                    //     itemCount: 2,
                    //     pageSnapping: true,
                    //     itemBuilder: (context,pagePosition){
                    //     return Container(
                    //       margin: EdgeInsets.all(10),
                    //       // child: Image.network(images[pagePosition]));
                    //              }),
                    //  ),
                    
                    Row(
                      
                      children: [
                        // Get.put(TheatreEditcontroller()).deleteTheatre(theaterId), m,
                        Card(
                          child: Container(
                            height: 70,
                            width: 80,
                            child:Image.network(theatre.image[0],fit: BoxFit.cover,),),
                        ),
              SizedBox(width: 20,),
             
                        Text(
                          '${theatre.name}',
                          style: MytextTheme.Medium15Text
                        ),

                      
                        
                      ],
                    ),

                      // Text(
                      //     '${theaterId}',
                      //     style: MytextTheme.Medium15Text
                      //   ),
                    SizedBox(height: 20,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                              'Location: Cochin',
                              style: MytextTheme.Medium15Text
                            ),
                            
                             Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(onPressed: (){
      Get.to( DateMainPage(theaterId:theaterId));  //========================Check for theatre id in this=======================================
                  }, child: Text('Timing')))
                       ],
                     ),
                
                  ],
                ),
              ),
            ),
          ),
           const Positioned(
              right: 40,
              top:-20,
              child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255))),
                   const Positioned(
              right: 40,
              bottom: -20,
              child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255))),

                  const Positioned(
              left: 40,
              top:-20,
              child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255))),
                   const Positioned(
              left: 40,
              bottom: -20,
              child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255))),
        ],
      ),
    );
  }
}