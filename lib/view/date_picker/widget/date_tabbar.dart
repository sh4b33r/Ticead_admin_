import 'dart:developer';
import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';
import 'package:admin_ticead/view/movie/screen/movie_screen.dart';
import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
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
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<String> times = [];
                      // // List<MovieModel> movies=[];

                      for (var doc in snapshot.data!.docs) {
                        times.addAll(List<String>.from(doc['Time']));
                      }

                      return ListView.builder(
                        itemCount: times.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                            tileColor: const Color.fromARGB(255, 55, 46, 19),
                            
                              title: InkWell(
                                onTap: () async{
                                  final oldtime=times[index].toString();
                              //  controller.check();
                              log(oldtime);
                                await  controller.selectTime(
                                      context,
                                      TimeOfDay(
                                          hour: int.tryParse(
                                                  times[index].substring(0, 2))
                                              as int,
                                          minute: int.tryParse(
                                                  times[index].substring(3, 5))
                                              as int));
                                        controller.sendDateTimedata( update:  true,oldtime:  oldtime,);
                                  //  log(int.tryParse(times[index].substring(0,2)).toString());
                                },
                                child: Text(
                                  times[index],
                                  style: const TextStyle(color: Colors.amber),
                                ),
                              ),
                              trailing: ElevatedButton(
                                  onPressed: () async{
                                    controller.currentEditingTIme.value=times[index];
                                    log(controller.currentEditingTIme.value.toString());
                                    log(controller.selectedDAte.value.toString());
                                    // await Get.find<MovieController>().getdatatoAllMovies();
                                    Get.to(MovieScreen(theaterId:theaterId));
                                  },
                                  child: Text('Select Movie')),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Lottie.asset(
                            'asset/lottie/Animation - 1708104826864.json'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Center(
                          child: Lottie.asset(
                              'asset/lottie/Animation - 1708146341657.json'));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
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
