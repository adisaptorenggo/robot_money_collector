import 'package:flutter/material.dart';

class TableTop extends CustomPainter {
  TableTop({this.dimensionx, this.dimensiony, this.width, this.height});

  final int dimensionx;
  final int dimensiony;
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    double dx = 0, dy = 0;
    for (int i = 0; i < dimensionx; i++) {
      // canvas.d
      canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paint1);
      canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paint2);
      for (int j = 0; j < dimensiony; j++) {
        canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paint1);
        canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paint2);
        dy = dy + height / dimensiony;
      }
      dy = 0;
      dx = dx + width / dimensionx;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
