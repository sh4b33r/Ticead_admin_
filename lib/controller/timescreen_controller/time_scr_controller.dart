import 'dart:developer';
import 'package:admin_ticead/model/constants/string_constant.dart';
import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:admin_ticead/model/shared_pref/shared_funcitons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TImeController extends GetxController {
  // Rx<DateTime?> selectedDate = (null).obs;
  Rx<TimeOfDay> selectedTime = (const TimeOfDay(hour: 10, minute: 10).obs);
  // Rx<String>? oldtime;
  Rx<DateTime> selectedDAte = DateTime.now().obs;
  Rx<String> currentEditingTIme = ''.obs;

  Rx<DatePickerController> datecontroller = DatePickerController().obs;
  var moviepage = [].obs;

  // check() {
  //   log(oldtime?.value ?? "Old time is null");
  // }

  Future<void> selectTime(BuildContext context,
      [TimeOfDay? editingTime]) async {
    TimeOfDay initialTime = editingTime ?? selectedTime.value;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
    log(selectedTime.toString());
  }

// sending slected time to firebase firestore add update all in one

  Future<void> sendDateTimedata(
      {bool update = false,
      String? oldtime,
      bool movie = false,
      MovieModel? movieDetails}) async {
    try {
      final fdata = await FirebaseFirestore.instance
          .collection('shows')
          .where('Date', isEqualTo: selectedDAte.value)
          .get();

      log(fdata.docs.isEmpty.toString());

      if (fdata.docs.isEmpty) {
        final id = await FirebaseFirestore.instance.collection('shows').add({
          'Date': selectedDAte.value,
          'Time': [selectedTime.value.toString().substring(10, 15)],
          // 'Time': '${selectedTime.value.hour.hours}:${selectedTime.value.minute.minutes}',
          'id': sharedInstance.getString(SCons.loginKey),
          'timestamp': FieldValue.serverTimestamp(),
        });

        log('DateTIme Added with ${id.id}');
      } else {
        log(fdata.docs.first['Time'].toString());
        // log(temp.toString());

        if (update) {
          //  Set<String> tmset = Set<String>.from(fdata.docs.first['Time']);
          List<dynamic> temp = List<String>.from(fdata.docs.first['Time']);
          temp.add(selectedTime.value.toString().substring(10, 15));

          log('entered into update =true');
          final indexToUpdate = temp.indexOf(oldtime);

          if (indexToUpdate != -1) {
            temp.removeAt(indexToUpdate);

            log('${temp} after removal');
            temp.insert(
                indexToUpdate, selectedTime.value.toString().substring(10, 15));
            log('${temp} after udpatedd');
            // log('${tmset} after udpaetd');
            log('true updated time and swapped old time');

            //    await FirebaseFirestore.instance
            // .collection('shows')
            // .doc(fdata.docs.first.id)
            // .update({'Time': temp});

            fdata.docs.first.reference.update({'Time': temp});

            log('updated  time in specific index  ');
          } else {
            Get.showSnackbar(const GetSnackBar(
              message: 'Error Occured While Updating Time',
              backgroundColor: Colors.red,
            ));
            log('No Time found');
          }
        } else {
             if (movie) {
          if (movie && movieDetails != null) {
            await fdata.docs.first.reference.update({
              'movies': {
                currentEditingTIme.value: {'title': movieDetails.title ,
                'overview': movieDetails.overview,
                'language': movieDetails.language ,'backdroppath': movieDetails.backdroppath,'originaltitle':movieDetails.originaltitle,'voterating': movieDetails.voterating,'posterpath': movieDetails.posterpath}
                
                  // MovieModel(title: movieDetails.title, language: movieDetails.language, backdroppath: movieDetails.backdroppath, originaltitle:movieDetails.originaltitle, overview: movieDetails.overview, voterating: movieDetails.voterating, posterpath: movieDetails.posterpath)
              },
            });
          }
          return;
        }


          Set<String> tmset = Set<String>.from(fdata.docs.first['Time']);
          List<String> temp = tmset.toList();

          temp.add(selectedTime.value.toString().substring(10, 15));
          await fdata.docs.first.reference.update({'Time': temp});
          log('Inserted time in a new field ');
        }
        
      }
      Get.showSnackbar(const GetSnackBar(
        message: 'Time Updated Successfully',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } catch (e) {
      log(e.toString());
    }
  }

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