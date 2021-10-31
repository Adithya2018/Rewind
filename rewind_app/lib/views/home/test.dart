import 'dart:math';
import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  bool isFront = true;
  double verticalDrag = 33.0;
  double horizontal = 0;
  @override
  Widget build(BuildContext context) {
    //verticalDrag = 20;
    //print(Matrix4.identity().toString());
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onVerticalDragStart: (details) {},
        onVerticalDragEnd: (details) {
          /*setState(() {
            verticalDrag %= 180;
          });*/
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            verticalDrag += (details.delta.dy);
            //verticalDrag *= 1.01;
            verticalDrag %= 360;
          });
          print(details.delta.toString());
          print(verticalDrag);
          print("x =${57.735027 * sin((verticalDrag / 180) * pi)}");
          print("z =${57.735027 * cos((verticalDrag / 180) * pi)}");
        },
        child: Stack(
          //alignment: Alignment.topLeft,
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 100,
              //top: 0,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                  ..translate(
                      57.735027 * sin(((verticalDrag - 120) / 180) * pi),
                      0.0,
                      57.735027 * cos(((verticalDrag - 120) / 180) * pi))
                  ..rotateY(((verticalDrag - 120) / 180) * pi),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                  ),
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Panel 1",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 100,
              //top: 0,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                  ..translate(57.735027 * sin((verticalDrag / 180) * pi), 0.0,
                      57.735027 * cos(((verticalDrag) / 180) * pi))
                  ..rotateY(((90) / 180) * pi),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                  ),
                  width: 200.0,
                  height: 200.0,
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Panel 2",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 100,
              //top: 0,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                  ..translate(
                      57.735027 * sin(((verticalDrag + 120) / 180) * pi),
                      0.0,
                      57.735027 * cos(((verticalDrag + 120) / 180) * pi))
                  ..rotateY(((verticalDrag + 120) / 180) * pi),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                  ),
                  width: 200.0,
                  height: 200.0,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Panel 3",
                      ),
                    ],
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
/*Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(verticalDrag / 180 * pi),
            alignment: Alignment.center,
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.blueGrey,
              child: Column(
                children: [
                  Text(
                    "Front",
                  ),
                ],
              ),
            ),
          ),*/
/*Container(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                color: Colors.transparent,
                child: GestureDetector(
                  onVerticalDragStart: (details) {},
                  onVerticalDragEnd: (details) {},
                  onHorizontalDragStart: (details) {},
                  onHorizontalDragEnd: (details) {},
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      horizontalDrag += (details.delta.dx);
                      //verticalDrag *= 1.01;
                      horizontalDrag %= 360;
                    });
                    print("drag = $horizontalDrag");
                    print(
                        "container width = ${MediaQuery.of(context).size.width - 80}");
                  },
                  onVerticalDragUpdate: (details) {
                    if (_scrollController.offset >=
                            _scrollController.position.maxScrollExtent &&
                        !_scrollController.position.outOfRange) {
                      print("dy = ${details.delta.dy}");
                      if (details.delta.dy < 0) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      } else {
                        _scrollController.jumpTo(
                            _scrollController.offset - details.delta.dy);
                      }
                    } else if (_scrollController.offset <=
                            _scrollController.position.minScrollExtent ||
                        _scrollController.position.outOfRange) {
                      if (details.delta.dy > 0) {
                        _scrollController
                            .jumpTo(_scrollController.position.minScrollExtent);
                      } else {
                        _scrollController.jumpTo(
                            _scrollController.offset - details.delta.dy);
                      }
                    } else {
                      print("dy = ${details.delta.dy}");
                      _scrollController
                          .jumpTo(_scrollController.offset - details.delta.dy);
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            (MediaQuery.of(context).size.width - 80) / 2,
                        top: 50,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                            ..translate(
                              r * sin(((horizontalDrag - 120) / 180) * pi),
                              0.0,
                              r * cos(((horizontalDrag - 120) / 180) * pi),
                            )
                            ..rotateY(((horizontalDrag - 120) / 180) * pi),
                          alignment: Alignment.center,
                          child: streakGraph,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            (MediaQuery.of(context).size.width - 80) / 2,
                        top: 50,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                            ..translate(
                              r * sin(((horizontalDrag) / 180) * pi),
                              0.0,
                              r * cos(((horizontalDrag) / 180) * pi),
                            )
                            ..rotateY(((horizontalDrag) / 180) * pi),
                          alignment: Alignment.center,
                          child: streakGraph,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            (MediaQuery.of(context).size.width - 80) / 2,
                        top: 50,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, -0.001) //(verticalDrag / 180) * pi
                            ..translate(
                              r * sin(((horizontalDrag + 120) / 180) * pi),
                              0.0,
                              r * cos(((horizontalDrag + 120) / 180) * pi),
                            )
                            ..rotateY(((horizontalDrag + 120) / 180) * pi),
                          alignment: Alignment.center,
                          child: streakGraph,
                        ),
                      ),

                    ],
                  ),
                ),
              ),*/