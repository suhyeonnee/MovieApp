import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class categoryBtn extends StatelessWidget {
  final String btnNm;
  final bool selectedFlag;
  final double btnWidth;

  const categoryBtn({
    super.key,
    required this.btnNm,
    required this.selectedFlag,
    required this.btnWidth,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: btnWidth+15,
      width: btnWidth,
      child: 
      Stack(
        children: [
          Positioned.fill(
            child: Image.asset(selectedFlag ? 'lib/img/btn_in.png' : 'lib/img/btn_out.png',
            fit: BoxFit.fitWidth),
          ),

          Align(
            alignment: Alignment(-0.1, -0.1),
            child:Text(
              btnNm,
              style: GoogleFonts.getFont(
                'New Rocker',
                fontSize: 18,
                color: Color.fromARGB(255, 119, 93, 42),
                shadows: [
                  // 윗쪽 그림자: 글자가 깊게 파인 느낌
                  Shadow(
                    offset: Offset(0, -1.5),       // 약간 더 깊게
                    blurRadius: 3,                 // 흐림 살짝 늘림
                    color: Color(0xCC665C38),     // 더 진한 갈색, 투명도 CC (~80%)
                  ),
                  // 아랫쪽 하이라이트: 금속 반사 느낌 최소화
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 1,
                    color: Color(0x22FFD580),     // 아주 약한 밝은 금색, 투명도 22 (~13%)
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
