import 'dart:developer';
import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';
import 'package:admin_ticead/view/movie/screen/movie_screen.dart';
import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DateWidget extends StatelessWidget {
 final String theaterId;
  const DateWidget({Key? key,required this.theaterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(top: 10),
      child: GetX<TImeController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DatePicker(
                DateTime.now(),
                daysCount: 7,
                // selectedDate: controller.selectedDAte.value,
                height: 100,
                width: 80,
                controller: controller.datecontroller.value,
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color.fromARGB(247, 231, 248, 235),
                selectedTextColor: const Color.fromARGB(255, 0, 0, 0),
                deactivatedColor: const Color.fromARGB(255, 235, 233, 233),
                dateTextStyle: const TextStyle(color: Colors.amber),
                dayTextStyle: const TextStyle(color: Colors.amber),
                monthTextStyle: const TextStyle(color: Colors.amber),
                onDateChange: (selectedDate) {
                  controller.selectedDAte.value = selectedDate;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "Selected Times Are :",
                style: TextStyle(color: Colors.amber),
              ),
              const SizedBox(height: 5),
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
          .collection('shows')
          .where('Date', isEqualTo: controller.selectedDAte.value)
          .snapshots(),
      //              FirebaseFirestore.instance
      // .collection('theaters')
      // .doc(controller.thatreoftimecurrent.value) // Use the specific theaterId
      // .collection('shows')
      // .where('Date', isEqualTo: controller.selectedDAte.value)
      // .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                     

                      log('keeeeeeeeeeeeeeri');
                      log('${snapshot.data!.docs.isEmpty}');
                      // List<String> times = [];
                      // // // List<MovieModel> movies=[];

                      // for (var doc in snapshot.data!.docs) {
                      //   times.addAll(List<String>.from(doc['Time'] as List<dynamic>));
                      // }
                        log(" >length>>${snapshot.data!.docs[0]['Time'].toString()}");
                      return ListView.builder(
                      
                        itemCount: snapshot.data!.docs[0]['Time'].length,
                        
                        itemBuilder: (context, index) {
                              final timeKey = snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1, 6);
                          log('${snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1,6)}');
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              

endActionPane: ActionPane(
    // A motion is a widget used to control how the pane animates.
    motion: const ScrollMotion(),


    

    children:  [
     
      SlidableAction(
        onPressed: (_){},
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
      
    ],),
    
startActionPane: ActionPane(
    // A motion is a widget used to control how the pane animates.
    motion: const ScrollMotion(),


    

    children:  [
     
      SlidableAction(
        onPressed: (_){


        },
        backgroundColor: Color.fromARGB(255, 47, 97, 197),
        foregroundColor: Colors.white,
        icon: Icons.edit,
        label: 'Edit',
      ),
      
    ],),
    
                              child: ColoredBox(
                                color: Color.fromARGB(115, 238, 245, 246),
                                child: ListTile(
                                tileColor: const Color.fromARGB(255, 55, 46, 19),
                                
                                  title: InkWell(
                                    onTap: () async{
                                      final oldtime=snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1,6);
                                  //  controller.check();
                                  log(oldtime);
                                    await  controller.selectTime(
                                          context,
                                          TimeOfDay(
                                              hour: int.tryParse(
                                                      snapshot.data!.docs[0]['Time'][index].keys.substring(0, 2))
                                                  as int,
                                              minute: int.tryParse(
                                                    snapshot.data!.docs[0]['Time'][index].keys.substring(3, 5))
                                                  as int));
                                            controller.sendDateTimedata( update:  true,oldtime:  oldtime,);
                                      //  log(int.tryParse(times[index].substring(0,2)).toString());
                                    },
                                    child: Text(
                                      snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1,6),
                                      style: const TextStyle(color: Color.fromARGB(255, 32, 32, 31)),
                                    ),
                                  ),
                                  trailing: snapshot.data!.docs[0]['Time'][index][timeKey] != null ?
                                  
                                  
                                  ElevatedButton(
                                      onPressed: () async{
                                        log("Date >> ${snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1,6)}");
                                        controller.currentEditingTIme.value=snapshot.data!.docs[0]['Time'][index].keys.toString().substring(1,6);
                                        log(controller.currentEditingTIme.value.toString());
                                        log(controller.selectedDAte.value.toString());
                                        // await Get.find<MovieController>().getdatatoAllMovies();
                                        Get.to(MovieScreen(theaterId:theaterId));
                                      },
                                      child: const Text('Select Movie')):Text('${snapshot.data!.docs[0]['Time'][index][timeKey]}')
                                
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else{
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Lottie.asset(
                              'asset/lottie/Animation - 1708104826864.json',height: 100,width: 100),
                        ),
                      );
                    } 
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}




