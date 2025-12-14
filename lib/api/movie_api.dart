import 'dart:convert';
import 'package:final_challenge/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String now = "now-playing";
  static const String coming = "coming-soon";

  static Future<List<MovieModel>> getPopularMoive() async {
    List<MovieModel> movieInstance = [];
    
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> moviesPage = jsonDecode(response.body);
      final List<dynamic> movies = moviesPage["results"];

      for(var m in movies){
        movieInstance.add(MovieModel.fromJson(m));
      }
      return movieInstance;
    }
    // 상세한 예외 메시지를 던져서 어디가 문제인지 알기 쉽게 함
    throw Exception('Failed to load moives. Status code: ${response.statusCode}');
  }

  //현재 상영 영화
  static Future<List<MovieModel>> getNowMovies() async{
    List <MovieModel> movieInstance = [];

    final url = Uri.parse('$baseUrl/$now');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final Map<String, dynamic> moviesPage = jsonDecode(response.body);
      final List<dynamic> movies = moviesPage['results'];

      for(var m in movies){
        movieInstance.add(MovieModel.fromJson(m));
      }

    return movieInstance;
    }
    throw Exception('Fail to load movies. Status code : ${response.statusCode}');
  }

  //개봉 예정작
  static Future<List<MovieModel>> getComingSoonMovie() async{
    final List<MovieModel> movieInstance = [];

    final url = Uri.parse('$baseUrl/$coming');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final Map<String, dynamic> moviesPage = jsonDecode(response.body);
      final List<dynamic> movies = moviesPage['results'];

      for(var m in movies){
        movieInstance.add(MovieModel.fromJson(m));
      }
      return movieInstance;
    }
    throw Exception('Fail to load movies. Status code : ${response.statusCode}');
  }
}