import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ach_common.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<Achievement> listOfAchievement = [];
  List<Container> listOfTiles = [];
  Container createAchievement({
    String label,
    String description,
    IconData rewardIcon,
    int progress,
    int required,
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
            child: CircleAvatar(
              child: Icon(
                rewardIcon,
                size: 30.0,
              ),
              radius: 46.0,
              backgroundColor: Colors.white,
            ),
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
          title: Row(
            children: [
              SizedBox(
                width: 7.0,
              ),
              Text(
                "Achievements",
                textAlign: TextAlign.left,
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
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
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [

              createAchievement(
                label: "Task master",
                description: "Complete 1000 Level 1 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Task master",
                description: "Complete 800 Level 2 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Task master",
                description: "Complete 600 Level 3 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Task master",
                description: "Complete 400 Level 4 tasks",
                rewardIcon: MaterialCommunityIcons.skull,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Diamond Medallion",
                description: "Complete 200 Level 5 tasks",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "New Kid",
                description: "Welcome to Rewind!",
                rewardIcon: MaterialCommunityIcons.baby_face,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Achiever",
                description: "Level 25",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Grand Task Master",
                description: "Level 50",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Enlightened Entity",
                description: "Level 75",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
              ),

              createAchievement(
                label: "Eternal Entity",
                description: "Level 100",
                rewardIcon: MaterialCommunityIcons.diamond_stone,
                progress: 0,
                required: 100,
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
              // createAchievement(
              //   label: "Hard worker",
              //   description: "Complete 10 Level 4 tasks",
              //   rewardIcon: MaterialCommunityIcons.donkey,
              //   progress: 0,
              //   required: 10,
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
