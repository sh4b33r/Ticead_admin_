import 'package:admin_ticead/model/movie_model/movie_model.dart';
import 'package:flutter/material.dart';

// ===================================================
// Model for Movies and times for Show named Database
// ---------------------------------------------------

class DateTimeMovie {
  final DateTime? date;
  MovieModel? movies;
  final TimeOfDay times;

  DateTimeMovie({required this.date, this.movies, required this.times});
}
