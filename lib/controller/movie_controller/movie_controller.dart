

import 'dart:async';
import 'dart:developer';

import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  
 @override
  void onInit() {
    super.onInit();
   fetchAlltomovies();
  }

 RxString searchval=''.obs;
  TextEditingController moviesearchController = TextEditingController();
  RxList<MovieModel> allMovies = <MovieModel>[].obs;
  RxList<MovieModel> searchListener = <MovieModel>[].obs;

 final StreamController<List<MovieModel>> _movieBrController =
      StreamController<List<MovieModel>>.broadcast();

  Stream<List<MovieModel>> get moviesStream => _movieBrController.stream;

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



fetchAlltomovies()async{
  log('>>>>>>>>>>>>>>>>   entererd into funtion');
  QuerySnapshot snapDatas=await _firestore.collection('Movie').get();

  allMovies.value=snapDatas.docs.map((sData) =>MovieModel(
              name: sData['name'],
              descripiton: sData['description'],
              rating: sData['rating'],
              genres: sData['genres'],
              backDrop: sData['backDrop'],
              poster: sData['poster'],
              language: sData['language']
            ))
        .toList();
        //  log(allMovies.toString());
        _movieBrController.add(allMovies.toList());
        
}


  void searchMovies(String textValue) {
    if (textValue.isEmpty) {
      _movieBrController.add(allMovies.toList());
    } else {
      List<MovieModel> searchResults = allMovies
          .where((movie) =>
              movie.name.toLowerCase().contains(textValue.toLowerCase()))
          .toList();
      _movieBrController.add(searchResults);
    }
  }

  
  // @override
  // void onClose() {
  //   __movieBrController.close();
  //   super.onClose();
  // }


}
