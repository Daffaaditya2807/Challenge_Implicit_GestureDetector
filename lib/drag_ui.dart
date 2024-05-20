import 'dart:math';

import 'package:flutter/material.dart';

class DragUi extends StatefulWidget {
  const DragUi({super.key});

  @override
  State<DragUi> createState() => _DragUiState();
}

class _DragUiState extends State<DragUi> {
  final double boxSize = 200.0;
  int totalTaps = 0;
  int totalDoubelTaps = 0;
  int totalLongTaps = 0;

  late double borderRadius;
  late double margin;
  late Color warna;

  double posX = 0.0;
  double posY = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    margin = randomMargin();
    borderRadius = randomBorderRadius();
    warna = randomCalor();
  }

  double randomBorderRadius() {
    return Random().nextDouble() * 20;
  }

  double randomMargin() {
    return Random().nextDouble() * 20;
  }

  Color randomCalor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
  // Color randomCalor() {
  //   int r = Random().nextInt(255);
  // }

  void changeState() {
    setState(() {
      borderRadius = randomBorderRadius();
      margin = randomMargin();
      warna = randomCalor();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(borderRadius);
    if (posX == 0) {
      _centerPosition(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Story"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: [
          Positioned(
            // duration: Duration(milliseconds: 500),
            // curve: Curves.ease,
            left: posX,
            top: posY,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  totalTaps++;
                  changeState();
                });
              },
              // onVerticalDragUpdate: (details) {
              //   setState(() {
              //     double verticalPosition = details.delta.dy;
              //     posY += verticalPosition;
              //   });
              // },
              // onHorizontalDragUpdate: (details) {
              //   setState(() {
              //     double horizontal = details.delta.dx;
              //     posX += horizontal;
              //   });
              // },
              onPanUpdate: (details) {
                setState(() {
                  posX += details.delta.dx;
                  posY += details.delta.dy;
                });
              },
              onDoubleTap: () {
                setState(() {
                  totalDoubelTaps++;
                });
              },
              onLongPress: () {
                setState(() {
                  totalLongTaps++;
                });
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.bounceIn,
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    color: warna,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Taps : $totalTaps"),
            Text("Double Taps : $totalDoubelTaps"),
            Text("Long Press : $totalLongTaps")
          ],
        ),
      ),
    );
  }

  void _centerPosition(BuildContext context) {
    posX = (MediaQuery.of(context).size.width - boxSize) / 2;
    posY = (MediaQuery.of(context).size.height - boxSize) / 2;
    setState(() {
      posX = posX;
      posY = posY;
    });
  }
}
