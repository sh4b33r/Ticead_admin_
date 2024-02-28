import 'dart:developer';
import 'dart:ffi';
import 'package:admin_ticead/controller/theatre_controller/theatre_controller.dart';
import 'package:admin_ticead/model/constants/string_constant.dart';
import 'package:admin_ticead/model/movie_model/movie_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TImeController extends GetxController {
  // Rx<DateTime?> selectedDate = (null).obs;
  RxString thatreoftimecurrent = ''.obs;
  Rx<TimeOfDay> selectedTime = (const TimeOfDay(hour: 10, minute: 10).obs);
  // Rx<String>? oldtime;
  Rx<DateTime> selectedDAte = DateTime.now().obs;
  Rx<String> currentEditingTIme = ''.obs;

  Rx<DatePickerController> datecontroller = DatePickerController().obs;
  var moviepage = [].obs;

  // check() {
  //   log(oldtime?.value ?? "Old time is null");
  // }

  Future<bool> selectTime(BuildContext context,
      [TimeOfDay? editingTime]) async {
        log(editingTime.toString());
    TimeOfDay initialTime = editingTime ?? selectedTime.value;
    final TimeOfDay? picked = await showTimePicker(
    
      context: context,
      initialTime: initialTime,
      
    );


    if (picked != null && picked != selectedTime.value) {
      log(' >>>>>>Slected tiem>>>>>>${selectedTime.value}');
      selectedTime.value = picked;
       log(' >>>>>>Slected new tiem>>>>>>${selectedTime.value}');
      return true;
    }else{
      return false;
    }
    // log({" slected time ${selectedTime.toString()}"} as String);
  }

  Future<void> 
  sendDateTimedata(

    {MovieModel? movieModel,
      bool update = false,
    String? oldtime,
    bool movie = false,
    MovieModel? movieDetails}) async {
  try {
    // final theaterRef = FirebaseFirestore.instance.collection('Show').doc(thatreoftimecurrent.value);

    final fdata = await FirebaseFirestore.instance
          .collection('shows')
          .where('TheatreId', isEqualTo: thatreoftimecurrent.value)
          .where('Date',isEqualTo: selectedDAte.value)
          .get();

    if (fdata.docs.isEmpty) {
  //  ----->   // Add time in Firestore when there's nothing on the specific date
       await FirebaseFirestore.instance.collection('shows').add({
        'Date': selectedDAte.value,
        'Time': [{selectedTime.value.toString().substring(10, 15):movieModel!.name.toString()}],
        'TheatreId': thatreoftimecurrent.value,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      await fdata.docs.first. reference.update({
        'Time': FieldValue.arrayUnion([{selectedTime.value.toString().substring(10, 15):movieModel!.name.toString()}]),
      
            
    
      }).then((value) {
return Get.showSnackbar(const GetSnackBar(
        message: 'Time Added Successfully',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        
      ));

      });



      
      
   


}
         
          
   

    
  } catch (e) {
    log(e.toString());
  }
// =====================================================
// Deltefield()async{
//   await FirebaseFirestore.instance.collection('shows').where(field) docs.first.reference.update({
//           'Time': FieldValue.arrayRemove([{oldtime: ''}]),
//         }).then((value) {
//           Get.showSnackbar(const GetSnackBar(
//             message: 'Time Deleted Successfully',
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ));
//         });


// }

//  =================================movie-===================
 
 }
 movieSending(MovieModel movieDetails)async{

  final fdata = await FirebaseFirestore.instance
          .collection('shows')
          .where('Date', isEqualTo: selectedDAte.value)
          .get();

            // var newMovie = {
            //   'title': movieDetails.name,
            //   'rating': movieDetails.rating,
            //   'language': movieDetails.language,
            //   'backdroppath': movieDetails.backDrop,
            //   'genre': movieDetails.genres,
          

              
            //   'posterpath': movieDetails.poster,
            // };
            log(currentEditingTIme.toString());
             fdata.docs.first.reference.update({
          
    'Time': FieldValue.arrayRemove([{currentEditingTIme.value: ''}]),
  });
         fdata.docs.first.reference.update({
          
    'Time': FieldValue.arrayUnion([{currentEditingTIme.value: movieDetails.name}]),
  
  });
         
          Get.showSnackbar(const GetSnackBar(
            message: 'Movie Added Successfully',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ));
          return;
 }
 
// ====================================================================
  toconvert(String conv) {
    int r = conv.length - 1;
    int l = 0;
    int retval = 0;

    while (l < r) {
      retval = retval * 10 + int.parse(conv[l]);
      l++;
    }

    return retval;
  }
}



































// Future<void> addTiming(context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );

//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );

//       if (pickedTime != null) {
        
//           selectedDate.value = pickedDate;
//           selectedTime.value = pickedTime;
  
//       }
//     }
//   }
// }