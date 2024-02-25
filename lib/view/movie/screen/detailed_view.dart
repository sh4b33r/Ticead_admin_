import 'package:admin_ticead/controller/timescreen_controller/time_scr_controller.dart';

import 'package:admin_ticead/view/theme/color_n_style/main_colors.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:get/get.dart';

class MovieDetailView extends StatelessWidget {
  final MovieModel selectedMovie;

  const MovieDetailView({Key? key, required this.selectedMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.black,title: Text(selectedMovie.name.toString()),),
      backgroundColor: MycolorTheme.custwhite,
      body: ListView(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Stack(
                children: [
                  // Container(
                  //   color: Colors.amber,
                  //   height: 300,
                  // width: 150,
                  
                  // ),
                  // --------------------------------------------------------
                  SizedBox(
                      height: 300,
                      width: 150,
                      child: Image.network(
                        selectedMovie.poster,
                        height: 250,
                        width: 30,
                      )),
                  // ==========================================================
                  Positioned(
                    left: 96,
                    top: 220,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 27,
                      child: CircleAvatar(
                        backgroundColor: MycolorTheme.mycolor,
                        radius: 26,
                        child: Text(
                          selectedMovie.rating.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                  child: Text(
              selectedMovie.name,
                style: MytextTheme.headingText
              )),
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Language: ${selectedMovie.genres.toUpperCase()}",
                      style: MytextTheme.Medium15Text
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                     selectedMovie.descripiton,
                     style: MytextTheme.Medium15Text,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )),
const SizedBox(height: 40,),

              Column(
                children: [
                  ElevatedButton(onPressed: (){

Get.find<TImeController>().sendDateTimedata(movie: true,movieDetails: selectedMovie);

                  }, child: const Text('Submit')),
                ],
              )
        ],
      ),
    );
  }
}