import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZigzagClipper extends CustomClipper<Path> {
  final double zigzagHeight;
  final double zigzagWidth;
  final double diamondSize;

  ZigzagClipper({
    this.zigzagHeight = 5,
    this.zigzagWidth = 10,
    this.diamondSize = 13,
  });

  @override
  Path getClip(Size size) {
    Path zigzagPath = Path();

    final double radiusCircle = 30;

    // 1. 전체 사각형
    final rectPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 2. 원형 펀칭
    final holePath = Path()
      // 상단
      ..addOval(Rect.fromCircle(center: Offset(0, 0), radius: radiusCircle))
      ..addOval(Rect.fromCircle(center: Offset(size.width, 0), radius: radiusCircle))
      // 중앙
      ..addOval(Rect.fromCircle(center: Offset(0, size.height * 0.8), radius: radiusCircle))
      ..addOval(Rect.fromCircle(center: Offset(size.width, size.height * 0.8), radius: radiusCircle));

    final punching = Path.combine(PathOperation.difference, rectPath, holePath);

    // 3. 상단 지그재그
    zigzagPath.moveTo(0, zigzagHeight);
    for (double x = 0; x < size.width; x += zigzagWidth) {
      zigzagPath.lineTo(x + zigzagWidth / 2, 0);
      zigzagPath.lineTo(x + zigzagWidth, zigzagHeight);
    }
    zigzagPath.lineTo(size.width, size.height);
    zigzagPath.lineTo(0, size.height);
    zigzagPath.close();

    // 4. 다이아몬드 구멍 Path
    Path diamondPath = Path();
    double startY = size.height * 0.785;
    for (double x = 0; x < size.width; x += diamondSize) {
      diamondPath.moveTo(x + diamondSize / 2, startY); // top
      diamondPath.lineTo(x + diamondSize, startY + diamondSize / 2); // right
      diamondPath.lineTo(x + diamondSize / 2, startY + diamondSize); // bottom
      diamondPath.lineTo(x, startY + diamondSize / 2); // left
      diamondPath.close();
    }

    // 5. 상단 지그재그 + 원형 펀칭 + 다이아몬드 합성
    Path combinedPath = Path.combine(
        PathOperation.intersect,
        punching,
        zigzagPath,
    );

    combinedPath = Path.combine(PathOperation.difference, combinedPath, diamondPath);

    return combinedPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
