import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:admin_ticead/controller/movie_controller/movie_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:admin_ticead/model/movie_model/movie_model.dart';

class Constants {
  static String apiKey = '?api_key=bda239d0434bc8e35365350d913ef224';
  static String imageBaseUrl = '';
  static String all = 'https://api.themoviedb.org/3/trending/all/day';
  static String baseUrl = 'https://api.themoviedb.org/3/';
  static String trending = 'https://api.themoviedb.org/3/trending/movie/day';
  static String tvShows = 'https://api.themoviedb.org/3/trending/tv/day';
  static String iMgurl = 'https://image.tmdb.org/t/p/w500/';
  static String upcoming = 'https://api.themoviedb.org/3/movie/upcoming';
}

class ApiCalling {
// ======================================
// for Seching and loading data from Tmdb
// --------------------------------------

  final cntrl = Get.put(MovieController());

  Future<List<MovieModel>> getdata(String base) async {
    final response = await http.get(Uri.parse("$base${Constants.apiKey}"));
 log('ivde etheek');
    if (response.statusCode == 200) {
      log('ivde 200 succes ehtek etheek');
      final List<dynamic> decodedData = jsonDecode(response.body)['results'];

      return decodedData.map((items) => MovieModel.fromJson(items)).toList();
    } else {
      log('Unexpected Response status code: >> ${response.statusCode}');
      throw Exception("Something Went Wrong  on >>${response.statusCode}");
    }
  }

  Future<void> searchData(String keyword) async {
    log(keyword);
    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/search/movie?query=$keyword&api_key=bda239d0434bc8e35365350d913ef224"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> decodedData = data['results'];
        final val =
            decodedData.map((json) => MovieModel.fromJson(json)).toList();
        cntrl.searchListener.clear();
        for (var element in val) {
          if (element.posterpath != null) {
            cntrl.searchListener.add(element);
          }
        }
        // searchListener.notifyListeners();
      } else {
        if (response.statusCode != 200) {
          log('Unexpected Response status code: >> ${response.statusCode}');
          throw Exception("Unexpected status code: ${response.statusCode}");
        }
      }
    } on HttpException catch (e) {
      log('Network Error Occured ${e.toString()}');
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      log('Something Occured ${e.toString()}');
      throw ('Something Occurred on : $e');
    }
  }
}




 