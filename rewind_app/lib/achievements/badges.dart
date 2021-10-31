import 'package:flutter/material.dart';

class AchievementBadge{
  Container createBadge(
    IconData? badgeIconData, {
    required Color? badgeIconColor,
    required Color inner1,
    required Color inner2,
    required Color outer1,
    Color? outer2,
    required Color outer3,
  }) {
    List<Color> innerGradientColors = [
      inner1,
      inner2,
    ];
    List<Color> outerGradientColors = [
      outer1,
    ];
    if (outer2 != null) {
      outerGradientColors.add(outer2);
    }
    outerGradientColors.add(outer3);
    Container badge = new Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: outerGradientColors,
        ),
      ),
      child: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: innerGradientColors,
            ),
          ),
          child: Center(
            child: Icon(
              badgeIconData,
              size: 35.0,
              color: badgeIconColor,
            ),
          ),
        ),
      ),
    );
    return badge;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.cyan[300],
          toolbarHeight: 60.0,
          title: Text(
            "Test",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.white,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              createBadge(
                Icons.stream,
                inner1: Colors.lightBlueAccent[400]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.purple[200],
                outer3: Colors.blue,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.deepOrange,
                inner2: Colors.yellow,
                outer1: Colors.white,
                outer2: Colors.orange,
                outer3: Colors.redAccent,
                badgeIconColor: Colors.red,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.blueGrey[800]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[200],
                outer3: Colors.blueGrey,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600]!,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                //inner1: Colors.red,
                inner1: Colors.blueGrey[200]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.brown[300],
                outer3: Colors.brown[500]!,
                badgeIconColor: Color(0xFFB0B3B7),
              ),
            ],
          ),
          Row(
            children: [
              createBadge(
                Icons.stream,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Color(0xFFB2E5E3),
                outer3: Colors.pink[200]!,
                badgeIconColor: Color(0xFFFEDFD8),
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.deepOrange,
                inner2: Colors.yellow,
                outer1: Colors.white,
                outer2: Colors.orange,
                outer3: Colors.redAccent,
                badgeIconColor: Colors.red,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600]!,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600]!,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.pinkAccent[100]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.grey[400],
                outer3: Colors.blueGrey,
                badgeIconColor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              createBadge(
                Icons.stream,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.red[100],
                outer3: Colors.blue[600]!,
                badgeIconColor: Colors.yellow[700],
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.yellow[200]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.yellow,
                outer3: Colors.red,
                badgeIconColor: Colors.yellow[600],
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.purpleAccent[100]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.purpleAccent[100],
                outer3: Colors.purple,
                badgeIconColor: Colors.purple,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black38,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blueGrey[100],
                outer3: Colors.black38,
                badgeIconColor: Colors.grey[800],
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blueGrey[100],
                outer3: Colors.black,
                badgeIconColor: Colors.black,
              ),
            ],
          ),
          Row(
            children: [
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.red[200],
                outer3: Colors.blueGrey,
                badgeIconColor: Colors.yellowAccent,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.brown,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.yellow[100],
                outer3: Colors.brown,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.yellow[600]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.orange[100],
                outer3: Color(0xFFB08D57),
                badgeIconColor: Color(0xFFB08D57),
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.black,
                outer1: Colors.white,
                outer2: Colors.black12,
                outer3: Colors.black,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.black,
                inner2: Colors.black,
                outer1: Colors.white,
                outer2: Colors.black12,
                outer3: Colors.black,
                badgeIconColor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              createBadge(
                Icons.stream,
                inner1: Colors.greenAccent[400]!,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.green[100],
                outer3: Colors.greenAccent[400]!,
                badgeIconColor: Colors.white,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.grey,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.black54,
                outer3: Colors.red,
                badgeIconColor: Colors.blueGrey,
              ),
              createBadge(
                Icons.stream,
                inner1: Colors.grey,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.black54,
                outer3: Colors.red,
                badgeIconColor: Colors.blueGrey,
              ),
            ],
          ),
        ],
      )
    );
  }
}

/*Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            child: CustomPaint(
              painter: BadgeLayout(),
            ),
          ),*/

class BadgeLayout extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width/2;
    double y = size.height/2;
    /*Paint outerRing = Paint()..color = Colors.blueGrey;
    canvas.drawCircle(Offset(x,y), 45.0, outerRing);
    canvas.drawCircle(Offset(x,y), 35.0, Paint()..color);*/

    var paint = Paint();
    paint.color = Colors.blueGrey;
    paint.strokeWidth = 1.0;
    var path = Path();
    print(size);
    path.moveTo(x-10, y-11);
    path.lineTo(x, y-30);
    path.lineTo(x+10, y-11);
    path.lineTo(x+10, y-11);
    path.lineTo(x+30, y-7);
    path.lineTo(x+16, y+9);
    path.lineTo(x+19, y+30);
    path.lineTo(x, y+21);
    path.lineTo(x-19, y+30);
    path.lineTo(x-16, y+9);
    path.lineTo(x-30, y-7);
    path.close();
    paint.style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BadgeLayout oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(BadgeLayout oldDelegate) {
    return true;
  }
}

class AchievementTest extends StatefulWidget {
  @override
  _AchievementTestState createState() => _AchievementTestState();
}

class _AchievementTestState extends State<AchievementTest> {
  Container createBadge(
      IconData badgeIconData, {
        required Color? badgeIconColor,
        required Color inner1,
        required Color inner2,
        required Color outer1,
        Color? outer2,
        required Color outer3,
      }) {
    List<Color> innerGradientColors = [
      inner1,
      inner2,
    ];
    List<Color> outerGradientColors = [
      outer1,
    ];
    if (outer2 != null) {
      outerGradientColors.add(outer2);
    }
    outerGradientColors.add(outer3);
    Container badge = new Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: outerGradientColors,
        ),
      ),
      child: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: innerGradientColors,
            ),
          ),
          child: Center(
            child: Icon(
              badgeIconData,
              size: 35.0,
              color: badgeIconColor,
            ),
          ),
        ),
      ),
    );
    return badge;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            elevation: 3.0,
            backgroundColor: Colors.cyan[300],
            toolbarHeight: 60.0,
            title: Text(
              "Test",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.more_vert_sharp,
                  color: Colors.white,
                  size: 30.0,
                ),
                tooltip: 'Refresh',
                onPressed: () {
                  Navigator.of(context).popUntil((route) => false);
                  Navigator.of(context).pushNamed('/');
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                createBadge(
                  Icons.stream,
                  inner1: Colors.lightBlueAccent[400]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.purple[200],
                  outer3: Colors.blue,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.deepOrange,
                  inner2: Colors.yellow,
                  outer1: Colors.white,
                  outer2: Colors.orange,
                  outer3: Colors.redAccent,
                  badgeIconColor: Colors.red,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.blueGrey[800]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blue[200],
                  outer3: Colors.blueGrey,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blue[300],
                  outer3: Colors.blue[600]!,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  //inner1: Colors.red,
                  inner1: Colors.blueGrey[200]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.brown[300],
                  outer3: Colors.brown[500]!,
                  badgeIconColor: Color(0xFFB0B3B7),
                ),
              ],
            ),
            Row(
              children: [
                createBadge(
                  Icons.stream,
                  inner1: Colors.white,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Color(0xFFB2E5E3),
                  outer3: Colors.pink[200]!,
                  badgeIconColor: Color(0xFFFEDFD8),
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.deepOrange,
                  inner2: Colors.yellow,
                  outer1: Colors.white,
                  outer2: Colors.orange,
                  outer3: Colors.redAccent,
                  badgeIconColor: Colors.red,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blue[300],
                  outer3: Colors.blue[600]!,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blue[300],
                  outer3: Colors.blue[600]!,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.pinkAccent[100]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.grey[400],
                  outer3: Colors.blueGrey,
                  badgeIconColor: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                createBadge(
                  Icons.stream,
                  inner1: Colors.white,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.red[100],
                  outer3: Colors.blue[600]!,
                  badgeIconColor: Colors.yellow[700],
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.yellow[200]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.yellow,
                  outer3: Colors.red,
                  badgeIconColor: Colors.yellow[600],
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.purpleAccent[100]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.purpleAccent[100],
                  outer3: Colors.purple,
                  badgeIconColor: Colors.purple,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black38,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blueGrey[100],
                  outer3: Colors.black38,
                  badgeIconColor: Colors.grey[800],
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.white,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.blueGrey[100],
                  outer3: Colors.black,
                  badgeIconColor: Colors.black,
                ),
              ],
            ),
            Row(
              children: [
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.red[200],
                  outer3: Colors.blueGrey,
                  badgeIconColor: Colors.yellowAccent,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.brown,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.yellow[100],
                  outer3: Colors.brown,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.yellow[600]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.orange[100],
                  outer3: Color(0xFFB08D57),
                  badgeIconColor: Color(0xFFB08D57),
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.black,
                  outer1: Colors.white,
                  outer2: Colors.black12,
                  outer3: Colors.black,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.black,
                  inner2: Colors.black,
                  outer1: Colors.white,
                  outer2: Colors.black12,
                  outer3: Colors.black,
                  badgeIconColor: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                createBadge(
                  Icons.stream,
                  inner1: Colors.greenAccent[400]!,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.green[100],
                  outer3: Colors.greenAccent[400]!,
                  badgeIconColor: Colors.white,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.grey,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.black54,
                  outer3: Colors.red,
                  badgeIconColor: Colors.blueGrey,
                ),
                createBadge(
                  Icons.stream,
                  inner1: Colors.grey,
                  inner2: Colors.white,
                  outer1: Colors.white,
                  outer2: Colors.black54,
                  outer3: Colors.red,
                  badgeIconColor: Colors.blueGrey,
                ),
              ],
            ),
          ],
        )
    );
  }
}
