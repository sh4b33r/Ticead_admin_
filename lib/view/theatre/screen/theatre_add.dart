import 'package:admin_ticead/view/theatre/widget/text_formcustom.dart';
import 'package:flutter/material.dart';

class TheatreaddScreen extends StatelessWidget {
  const TheatreaddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Color.fromARGB(255, 201, 207, 201) ,
 body: Padding(
   padding: const EdgeInsets.all(20),
   child: Stack(
    
    
    children: [
      
     
      Container(
         height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration( 
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color:Color.fromARGB(255, 226, 252, 222),
          
          boxShadow:[
            
           BoxShadow(
    color: Color.fromARGB(255, 0, 0, 0),
    blurStyle: BlurStyle.outer,
    spreadRadius: 4,
    offset: Offset(1, 2),
    blurRadius: 15
  )],
          
          ),
          child: SingleChildScrollView(child: TexTFormfields(),),
       ),
      
       const Positioned(
        right: -21,
        top: 140,
        child: CircleAvatar(backgroundColor: Color.fromARGB(255, 237, 252, 222) )),



        Image.asset('asset/image/Vector_10.png',),
         Positioned(
          right: 0,
          child: Image.asset('asset/image/Vector_10.png',)),
       const Positioned(
        
        left: -21,
        top: 140,
        child: CircleAvatar(backgroundColor:Color.fromARGB(255, 237, 252, 222) )),
       


      ]),
 ),

    );
  }
}