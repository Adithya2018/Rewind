import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ach_common.dart';
import 'badges.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  //List<Achievement> listOfAchievement = [];
  //List<Container> listOfTiles = [];
  AchievementBadge badge = new AchievementBadge();
  Container createAchievement({
    String label,
    String description,
    IconData rewardIcon,
    int progress,
    int required,
    @required Color badgeIconColor,
    @required Color inner1,
    @required Color inner2,
    @required Color outer1,
    Color outer2,
    @required Color outer3,
  }) {
    Container achievement = Container(
      //height: 110.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFE6E7E7),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 60.0,
              maxHeight: 60.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: badge.createBadge(
              rewardIcon,
              inner1: inner1,
              inner2: inner2,
              outer1: outer1,
              outer2: outer2,
              outer3: outer3,
              badgeIconColor: badgeIconColor,
            ), /*CircleAvatar(
              child: Icon(
                rewardIcon,
                size: 30.0,
              ),
              radius: 46.0,
              backgroundColor: Colors.white,
            ),*/
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    label,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$progress/",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return achievement;
  }

  Achievement achievement = new Achievement();
  @override
  void initState() {
    super.initState();
    achievement.label = "Speed demon";
    achievement.description =
        "Complete 3 Level 3 tasks with 80% time remaining";
    achievement.rewardIcon = MaterialCommunityIcons.emoticon_devil;
    achievement.progress = 0;
    achievement.required = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Text(
            "Achievements",
            textAlign: TextAlign.left,
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 22,
              color: Colors.black,
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
                print("options");
              },
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              createAchievement(
                label: "Bomb",
                description: "Locked!",
                rewardIcon: MaterialCommunityIcons.lock,
                progress: 0,
                required: 100,
                inner1: Colors.grey[600],
                inner2: Colors.grey[300],
                outer1: Colors.white,
                outer2: Colors.black54,
                outer3: Colors.grey[200],
                badgeIconColor: Colors.blueGrey,
              ),
              createAchievement(
                label: "Task master",
                description: "Complete 100 Level 1 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
                inner1: Colors.blueGrey[800],
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[200],
                outer3: Colors.blueGrey,
                badgeIconColor: Colors.white,
              ),
              createAchievement(
                label: "Diamond Medallion",
                description: "Complete 20 Level 5 tasks",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
                inner1: Colors.pinkAccent[100],
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.grey[400],
                outer3: Colors.blueGrey,
                badgeIconColor: Colors.white,
              ),
              createAchievement(
                label: "New Kid",
                description: "Welcome to Rewind!",
                rewardIcon: MaterialCommunityIcons.baby_face,
                progress: 0,
                required: 100,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Color(0xFFB2E5E3),
                outer3: Colors.pink[200],
                badgeIconColor: Color(0xFFFEDFD8),
              ),
              createAchievement(
                label: "Speed demon",
                description: "Complete 3 Level 3 tasks with 80% time remaining",
                rewardIcon: MaterialCommunityIcons.emoticon_devil,
                progress: 0,
                required: 100,
                inner1: Colors.deepOrange,
                inner2: Colors.yellow,
                outer1: Colors.white,
                outer2: Colors.orange,
                outer3: Colors.redAccent,
                badgeIconColor: Colors.red,
              ),
              createAchievement(
                label: "Yin-Yang",
                description: "Welcome to Rewind!",
                rewardIcon: MaterialCommunityIcons.yin_yang,
                progress: 0,
                required: 100,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blueGrey[100],
                outer3: Colors.black,
                badgeIconColor: Colors.black,
              ),
              createAchievement(
                label: "Night owl",
                description: "Welcome to Rewind!",
                rewardIcon: MaterialCommunityIcons.owl,
                progress: 0,
                required: 100,
                inner1: Colors.black,
                inner2: Colors.black,
                outer1: Colors.white,
                outer2: Colors.black12,
                outer3: Colors.black,
                badgeIconColor: Colors.white,
              ),
              createAchievement(
                label: "Early bird",
                description: "Level 25",
                rewardIcon: MaterialCommunityIcons.weather_sunny,
                progress: 0,
                required: 100,
                inner1: Colors.yellow[100],
                inner2: Colors.lightBlue[100],
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.greenAccent[200],
                badgeIconColor: Colors.yellow[700],
              ),
              createAchievement(
                label: "Bomb",
                description: "Welcome to Rewind!",
                rewardIcon: MaterialCommunityIcons.bomb,
                progress: 0,
                required: 100,
                inner1: Colors.grey,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.black54,
                outer3: Colors.red,
                badgeIconColor: Colors.blueGrey,
              ),
              /*createAchievement(
                label: "Hard worker",
                description: "Complete 10 Level 4 tasks",
                rewardIcon: MaterialCommunityIcons.donkey,
                progress: 0,
                required: 10,
              ),*/
              createAchievement(
                label: "Achiever",
                description: "Level 25",
                rewardIcon: MaterialCommunityIcons.star_face,
                progress: 0,
                required: 100,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.red[100],
                outer3: Colors.blue[600],
                badgeIconColor: Colors.yellow[700],
              ),
              createAchievement(
                label: "Grand Task Master",
                description: "Level 50",
                rewardIcon: MaterialCommunityIcons.star_outline,
                progress: 0,
                required: 100,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600],
                badgeIconColor: Colors.white,
              ),

              createAchievement(
                label: "Enlightened Entity",
                description: "Level 75",
                rewardIcon: MaterialCommunityIcons.star_half,
                progress: 0,
                required: 100,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600],
                badgeIconColor: Colors.white,
              ),

              createAchievement(
                label: "Eternal Entity",
                description: "Level 100",
                rewardIcon: MaterialCommunityIcons.star,
                progress: 0,
                required: 100,
                inner1: Colors.black,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[300],
                outer3: Colors.blue[600],
                badgeIconColor: Colors.white,
              ),
              createAchievement(
                label: "Eternal Entity",
                description: "Level 25",
                rewardIcon: MaterialCommunityIcons.star,
                progress: 0,
                required: 100,
                inner1: Colors.white,
                inner2: Colors.white,
                outer1: Colors.white,
                outer2: Colors.blue[100],
                outer3: Colors.purple[400],
                badgeIconColor: Colors.yellow[700],
              ),

              SizedBox(
                height: 10,
              ),
              // createAchievement(
              //   label: "Speed demon",
              //   description: "Complete 3 Level 3 tasks with 80% time remaining",
              //   rewardIcon: MaterialCommunityIcons.emoticon_devil,
              //   progress: 0,
              //   required: 3,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

/*createAchievement(
                label: "Diamond medallion",
                description: "Complete 100 Level 5 tasks",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
              ),
              createAchievement(
                label: "Task master",
                description: "Complete 100 Level 3 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
              ),
              createAchievement(
                label: "Speed demon",
                description: "Complete 3 Level 3 tasks with 80% time remaining",
                rewardIcon: MaterialCommunityIcons.emoticon_devil,
                progress: 0,
                required: 3,
              ),
              createAchievement(
                label: "Hard worker",
                description: "Complete 10 Level 4 tasks",
                rewardIcon: MaterialCommunityIcons.donkey,
                progress: 0,
                required: 10,
              ),*/

/*Container(
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  style: GoogleFonts.gloriaHallelujah(),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                      //labelText: "Search",
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      suffixIcon: ElevatedButton(
                        child: Icon(MaterialCommunityIcons.magnify),
                        onPressed: () {
                          print("Search achievements");
                        },
                      )),
                ),
              ),*/
