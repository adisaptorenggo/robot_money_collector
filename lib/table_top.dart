import 'package:flutter/material.dart';

import 'constants.dart';

class TableTop extends CustomPainter {
  TableTop(
      {this.width,
      this.height,
      this.dimensionx,
      this.dimensiony,
      this.robotx,
      this.roboty,
      this.direction,
      this.xMoney,
      this.yMoney,
      this.posMoney});

  final double width;
  final double height;
  final int dimensionx;
  final int dimensiony;
  final double robotx;
  final double roboty;
  final int direction;
  final List<int> xMoney;
  final List<int> yMoney;
  var posMoney;

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    var paintBoxFill = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    var paintBoxBorder = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    double dx = 0, dy = 0;
    for (int i = 0; i < dimensionx; i++) {
      // canvas.d
      canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paintBoxFill);
      canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paintBoxBorder);
      for (int j = 0; j < dimensiony; j++) {
        canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paintBoxFill);
        canvas.drawRect(Offset(dx, dy) & Size(width / dimensionx, height / dimensiony), paintBoxBorder);
        dy = dy + height / dimensiony;
      }
      dy = 0;
      dx = dx + width / dimensionx;
    }
    final paintLine = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;
    double xLine1, yLine1, xLine2, yLine2;
    double xArrow1, yArrow1, xArrow2, yArrow2;
    double xArrow3, yArrow3, xArrow4, yArrow4;
    switch (direction) {
      case north:
        xLine1 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yLine1 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.25;
        xLine2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yLine2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.75;
        canvas.drawLine(Offset(xLine1, yLine1), Offset(xLine2, yLine2), paintLine);
        xArrow1 = xLine1;
        yArrow1 = yLine1;
        xArrow2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.25;
        yArrow2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xArrow1, yArrow1), Offset(xArrow2, yArrow2), paintLine);
        xArrow3 = xLine1;
        yArrow3 = yLine1;
        xArrow4 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.75;
        yArrow4 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xArrow3, yArrow3), Offset(xArrow4, yArrow4), paintLine);
        break;
      case east:
        xLine1 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.25;
        yLine1 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        xLine2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.75;
        yLine2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xLine1, yLine1), Offset(xLine2, yLine2), paintLine);
        xArrow1 = xLine2;
        yArrow1 = yLine2;
        xArrow2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yArrow2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.25;
        canvas.drawLine(Offset(xArrow1, yArrow1), Offset(xArrow2, yArrow2), paintLine);
        xArrow3 = xLine2;
        yArrow3 = yLine2;
        xArrow4 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yArrow4 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.75;
        canvas.drawLine(Offset(xArrow3, yArrow3), Offset(xArrow4, yArrow4), paintLine);
        break;
      case south:
        xLine1 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yLine1 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.25;
        xLine2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yLine2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.75;
        canvas.drawLine(Offset(xLine1, yLine1), Offset(xLine2, yLine2), paintLine);
        xArrow1 = xLine2;
        yArrow1 = yLine2;
        xArrow2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.25;
        yArrow2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xArrow1, yArrow1), Offset(xArrow2, yArrow2), paintLine);
        xArrow3 = xLine2;
        yArrow3 = yLine2;
        xArrow4 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.75;
        yArrow4 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xArrow3, yArrow3), Offset(xArrow4, yArrow4), paintLine);
        break;
      case west:
        xLine1 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.25;
        yLine1 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        xLine2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.75;
        yLine2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.5;
        canvas.drawLine(Offset(xLine1, yLine1), Offset(xLine2, yLine2), paintLine);
        xArrow1 = xLine1;
        yArrow1 = yLine1;
        xArrow2 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yArrow2 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.25;
        canvas.drawLine(Offset(xArrow1, yArrow1), Offset(xArrow2, yArrow2), paintLine);
        xArrow3 = xLine1;
        yArrow3 = yLine1;
        xArrow4 = ((width / dimensionx) * robotx) + (width / dimensionx) * 0.5;
        yArrow4 = ((height / dimensiony) * roboty) + (height / dimensiony) * 0.75;
        canvas.drawLine(Offset(xArrow3, yArrow3), Offset(xArrow4, yArrow4), paintLine);
        break;
      default:
    }
    for (int i = 0; i < 4; i++) {
      double sizeFont = ((width / dimensionx) * 0) + (width / dimensionx) * 0.25;
      final textStyle = TextStyle(color: Colors.greenAccent, fontSize: sizeFont, fontWeight: FontWeight.bold);
      final textSpan = TextSpan(
        text: posMoney[xMoney[i]][yMoney[i]] != null ? '\$${posMoney[xMoney[i]][yMoney[i]]}' : '',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: width,
      );
      final xNum = ((width / dimensionx) * xMoney[i].toDouble()) + (width / dimensionx) * 0.1;
      final yNum = ((height / dimensiony) * yMoney[i].toDouble()) + (height / dimensiony) * 0.35;
      final offset = Offset(xNum, yNum);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  // @override
  // bool shouldRepaint(TableTop oldPainter) {
  //   print('here');

  //   return oldPainter.dimensionx != dimensionx ||
  //       oldPainter.dimensiony != dimensiony ||
  //       oldPainter.robotx != robotx ||
  //       oldPainter.roboty != roboty ||
  //       oldPainter.direction != direction;
  // }
}
