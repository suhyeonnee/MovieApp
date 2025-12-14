import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';


class Detail extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  final String overview;
  final String releaseDate;
  final double starRate;
  final List<dynamic> genreList;
  final String movieId;

  const Detail({
    super.key,
    required this.movieTitle,
    required this.moviePoster,
    required this.overview,
    required this.releaseDate,
    required this.starRate,
    required this.genreList,
    required this.movieId,
  });

  static Map<int, String> genreMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };

  String getGenreNames(List<dynamic> genreIds) =>
      genreIds.map((id) => genreMap[id] ?? "Unknown").join(", ");

  Widget buildStarRow(double rate) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rate) {
          return Icon(Icons.star, color: Color(0xFFF4DA68).withAlpha(200), size: 50);
        } else if (index + 0.5 <= rate) {
          return Icon(Icons.star_half, color: Color(0xFFF4DA68).withAlpha(200), size: 50);
        } else {
          return Icon(Icons.star_border, color: Color(0xFFF4DA68).withAlpha(200), size: 50);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            // 배경 이미지
            Positioned.fill(
              child: Image.asset('lib/img/cinema_background.jpg', fit: BoxFit.fitHeight),
            ),

            

            // 포스터
            Positioned(
              width: 350,
              height: 240,
              top: 150,
              left: 40,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$moviePoster',
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.85),
                alignment: Alignment.center,
              ),
            ),

            // 커튼 장식
            Positioned(
              top: 100,
              left: -40,
              width: 500,
              child: Image.asset(
                'lib/img/curtain.png',
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.9),
              ),
            ),

            // 제목
            /*Positioned(
              top: 460,
              left: 0,
              right: 0,
              child: Text(
                movieTitle,
                style: GoogleFonts.getFont(
                  'New Rocker',
                  fontSize: 50,
                  color: Colors.white,
                ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            )*/
            Positioned(
  top: 460,
  left: 0,
  right: 0,
  child: SizedBox(
    height: 50, // 한 줄 높이
    child: Marquee(
      text: movieTitle,
      style: GoogleFonts.getFont(
        'New Rocker',
        fontSize: 50,
        color: Colors.white,
      ),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 50,       // 좌우 간격
      velocity: 50,         // 속도 조절
      pauseAfterRound: Duration(seconds: 1),
      startPadding: 10,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(seconds: 1),
      decelerationCurve: Curves.easeOut,
    ),
  ),
),

            // 장르
            Positioned(
              bottom: 370,
              left: 0,
              right: 0,
              child: Text(
                getGenreNames(genreList),
                style: GoogleFonts.getFont(
                  'New Rocker',
                  fontSize: 13,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // 구분선
            Positioned(
              bottom: 350,
              left: 40,
              right: 40,
              child: Container(
                height: 2,
                color: Colors.white30,
              ),
            ),

            // 별점
            Positioned(
              bottom: 300,
              left: 80,
              right: 0,
              child: buildStarRow(starRate),
            ),

            // 개요
            Positioned(
              bottom: 70,
              left: 30,
              right: 30,
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Text(
                    overview,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
