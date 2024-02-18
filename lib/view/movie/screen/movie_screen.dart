import 'dart:async';

import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:admin_ticead/model/app_calling/tmdb_api.dart';
import 'package:admin_ticead/view/movie/widget/mv_searchbuilder.dart';
import 'package:admin_ticead/view/theme/color_n_style/styletheme.dart';
import 'package:admin_ticead/view/theme/text_theme/main_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.find<MovieController>();
    Timer? _debounce;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      // color: const Color.fromARGB(255, 61, 61, 137),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Color.fromARGB(255, 227, 247, 224),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: TextField(
                                  controller: cntrl.moviesearchController,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      // searchEmptyData();
                                    } else {
                                      if (_debounce?.isActive ?? false) {
                                        _debounce?.cancel();
                                      }
                                      _debounce = Timer(
                                          const Duration(milliseconds: 800),
                                          () {
                                        ApiCalling().searchData(value);
                                      });
                                    }
                                  },
                                  decoration:
                                      Styles().formDecorationStyleWithSufix(
                                          labelText: 'Search Movies',
                                          icon: const Icon(Icons.movie),
                                          sufix: InkWell(
                                              onTap: () async{
                                                await cntrl.searchEmptyData();
                                                cntrl.moviesearchController
                                                    .clear();
                                                // ApiCalling().searchData("");
                                             
                                              },
                                              child: const SizedBox(child: Icon(Icons.close)))),
                                  style: MytextTheme.descriptionText),
                            ),
                          ),

                          // const Text('Your Text Widget'),
                          // Image.asset('Your Image Asset Path'),
                          const SingleChildScrollView(
                              child: SearchUpdateWidget())
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                      right: -27,
                      top: 140,
                      child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255))),
                  Positioned(
                      right: 5,
                      left: 5,
                      top: 4,
                      child: Image.asset(
                        'asset/image/sibgezigaga.png',
                      )),
                  const Positioned(
                      left: -27,
                      top: 140,
                      child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
