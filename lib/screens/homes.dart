import 'package:final_challenge/api/movie_api.dart';
import 'package:final_challenge/widgets/category_btn.dart';
import 'package:final_challenge/widgets/movie_box.dart';
import 'package:final_challenge/models/movie_model.dart';
import 'package:flutter/material.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  // API
  final Future<List<MovieModel>> moviePop = MovieApi.getPopularMoive();
  final Future<List<MovieModel>> movieNow = MovieApi.getNowMovies();
  final Future<List<MovieModel>> movieCom = MovieApi.getComingSoonMovie();

  int selectedIndex = 0;
  final List<String> category = ['Popular', 'Now', 'Comming'];

  Widget movieSection(Future<List<MovieModel>> future) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // 티켓 투입구
       Positioned(
        top: 0,
        child: Container(
          height: 35,
          width: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                spreadRadius: 1, 
                blurRadius: 5,
                offset: Offset(0, 9)
                ),
              ],
          ),
          child: Image.asset(
            'lib/img/insert_slot.png',
            fit: BoxFit.cover,
            ),
          ),
        ),
        
        // 영화 티켓 PageView
        Positioned(
          top: 14, // 티켓이 투입구 상단에 닿도록 조정
          child: SizedBox(
            height: 580,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<MovieModel>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    controller: PageController(viewportFraction: 0.65),
                    itemBuilder: (context, index) {
                      var movie = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: MovieBox(
                          poster: movie.detailPoster,
                          title: movie.title,
                          boxWidth: 220,
                          boxHigth: 500,
                          storyLine: movie.overview,
                          release: movie.releaseDate,
                          rate: movie.voteAverage,
                          genre: movie.genre,
                          id: '${movie.movieId}',
                          detailPoster:movie.poster
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<List<MovieModel>> selectedFuture;
    switch (selectedIndex) {
      case 0:
        selectedFuture = moviePop;
        break;
      case 1:
        selectedFuture = movieNow;
        break;
      default:
        selectedFuture = movieCom;
    }

    return Scaffold(
      body:
      Stack(
        children: [
          Positioned.fill(child: Image.asset('lib/img/background_red.jpg', fit:BoxFit.fill) ),
          Column(
            children: [
              SizedBox(height: 100),
          
              // 영화 섹션
              SizedBox(
                height: 600,
                width: MediaQuery.of(context).size.width,
                child: movieSection(selectedFuture),
              ),

              SizedBox(height: 30),
         
              // 카테고리 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(category.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: categoryBtn(
                      btnNm: category[index],
                      btnWidth: 120,
                      selectedFlag: isSelected,
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
