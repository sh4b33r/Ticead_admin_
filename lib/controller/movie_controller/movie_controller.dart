

import 'dart:async';

import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_stub/_file_decoder_stub.dart';

class MovieController extends GetxController {
 
 @override
  void onInit() {
    super.onInit();
   fetchAlltomovies();
  }


  TextEditingController moviesearchController = TextEditingController();
  RxList<MovieModel> allMovies = <MovieModel>[].obs;
  RxList<MovieModel> searchListener = <MovieModel>[].obs;

 final StreamController<List<MovieModel>> _movieBrController =
      StreamController<List<MovieModel>>.broadcast();

  Stream<List<MovieModel>> get moviesStream => _movieBrController.stream;

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


fetchAlltomovies()async{
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
