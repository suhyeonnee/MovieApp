class MovieModel {
  //포스터, 제목, 등급, 개요, 장르
  final String poster, title, overview, detailPoster, releaseDate;
  final bool grade;
  final List<dynamic> genre;
  final double voteAverage;
  final int movieId;

//기본 생성자 대신 named Constructor 사용
  MovieModel.fromJson(Map<String, dynamic> json) :
  poster = json['backdrop_path']??'',
  detailPoster = json['poster_path'],
  releaseDate = json['release_date'],
  title = json['title'],
  grade = json['adult'],
  overview = json['overview'],
  genre = json['genre_ids'],
  movieId = json['id'],
  voteAverage = json['vote_average'].toDouble();

}
