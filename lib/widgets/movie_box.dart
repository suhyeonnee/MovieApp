import 'package:final_challenge/screens/detail.dart';
import 'package:final_challenge/widgets/zigzag_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieBox extends StatefulWidget {

  final String poster;
  final String? title;
  final double boxWidth;
  final double? boxHigth;
  final String? storyLine;
  final String? release;
  final double? rate;
  final List<dynamic>? genre;
  final String? id;
  final String detailPoster;

  const MovieBox({
    super.key,
    required this.poster,
    required this.boxWidth,
    this.storyLine,
    this.release,
    this.boxHigth,
    this.title,
    this.rate,
    this.genre,
    required this.id,
    required this.detailPoster
  });

  @override
  State<MovieBox> createState() => _MovieBoxState();
}

class _MovieBoxState extends State<MovieBox> {
  
  bool pressFlag = false;
  double posY = 0; 
  
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        GestureDetector(
          //events
          onTapDown: (detail)=>{
            setState(() {
              pressFlag = true;
            }) 
          },
          onTapUp: (detail) =>{
            setState(() {
              pressFlag = false;  
            }) 
          },

          onVerticalDragUpdate: (details){
            if(details.delta.dy <0){
              setState(() {
                posY += details.delta.dy;
              });
            }
            else if(details.delta.dy>0){
              setState(() {
                if(posY<20){
                  posY += details.delta.dy;
                }
              });
            }
          },

          onVerticalDragEnd: (details) {
            bool detailOpen = posY < -150;

            setState(() {
              posY = 0;
            });

            if (detailOpen) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                    movieTitle: widget.title!,
                    moviePoster: widget.poster,
                    overview: widget.storyLine ?? '',
                    releaseDate: widget.release ?? '',
                    starRate: (widget.rate ?? 0).toDouble(),
                    genreList: widget.genre ?? [],
                    movieId: widget.id!
                    ),
                ),
              );
            }
          },
        
          child: Transform.translate(
            offset: Offset(0, posY),
            child: Padding(
              padding: EdgeInsets.only(top:70),
              child: ClipPath(
                clipper: ZigzagClipper(),
                child: Container(
                  width: widget.boxWidth,
                  height:widget.boxHigth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(60),
                        offset: const Offset(0,0),
                        blurRadius: 5
                        )
                    ]
                  ),
                   child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 224, 211, 175),
                          )
                        ),
                      ),

                      Column(
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500${widget.poster}',
                            fit: BoxFit.cover,
                            width: widget.boxWidth,
                            height: widget.boxHigth! - 100,
                          ),
                          SizedBox(height: 20),
                          
                          Container(
                            height: 70,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child : Text(widget.title!, style: GoogleFonts.getFont('New Rocker', fontSize: 30), overflow: TextOverflow.ellipsis)
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),  
      ],
    );
  }
}