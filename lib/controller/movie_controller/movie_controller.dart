import 'dart:developer';

import 'package:admin_ticead/model/app_calling/tmdb_api.dart';
import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  TextEditingController moviesearchController = TextEditingController();
  RxList<MovieModel> allMovies = <MovieModel>[].obs;
  RxList<MovieModel> searchListener = <MovieModel>[].obs;


  // @override
  //  void onInit(){
  //   super.onInit();
  // }

  getdatatoAllMovies()async{

     allMovies.value = await ApiCalling().getdata(Constants.all);
    // log(allMovies.value.toString());
  }

  

  searchEmptyData() {
    searchListener.clear();
    log(searchListener.value.toString());
        searchListener.addAll(allMovies);
         log(searchListener.value.toString());
    // searchListener.value=allMovies;
  }
}
