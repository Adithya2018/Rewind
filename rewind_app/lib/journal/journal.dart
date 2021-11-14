import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/controllers/edit_journal_page_ctrl.dart';
import 'package:rewind_app/controllers/journal_ctrl.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import 'edit_journal_page.dart';

class Journal extends GetWidget<JournalController> {
  RxList<Container> listTiles = RxList();
  bool? ascendingOrder = true;
  int? sortByOption = 0;
  TaskLevel taskLevel = TaskLevel();
  bool showActive = true;

  bool isSameDate(DateTime d1, DateTime d2) =>
      d2.day == d1.day && d2.month == d1.month && d2.year == d1.year;

  String dateToString(DateTime date) {
    DateTime now = DateTime.now();
    String result = "${date.day} ${dtf.month[date.month - 1]}";
    bool dateToday = isSameDate(now, date);
    result = dateToday ? "Today" : result;
    bool dateTomorrow = isSameDate(
        now.add(Duration(
          days: 1,
        )),
        date);
    result = dateTomorrow ? "Tomorrow" : result;
    print("${now.year}");
    result += (date.year == now.year) ? "" : ", ${date.year}";
    return result;
  }

  Container listTile({
    required int index,
  }) {
    final list = controller.journalData.value!.pages;
    DateTime created = list[index]!.created;
    TimeOfDay timeOfDay = TimeOfDay(
      hour: created.hour,
      minute: created.minute,
    );
    Container timeContainer = Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${dtf.formatTime(timeOfDay)}",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    Container titleArea = Container(
      padding: EdgeInsets.only(
        left: 10.0,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        list[index]!.title!,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
    Container contentArea = Container(
      padding: EdgeInsets.only(
        left: 10.0,
        bottom: 10.0,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        list[index]!.content!.isEmpty ? "<no content>" : list[index]!.content!,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 12,
          color: Colors.black,
        ),
        maxLines: 3,
      ),
    );

    Container framedContainer = Container(
      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
          bottom: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(1.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          timeContainer,
          GestureDetector(
            onTap: () async {
              Get.put(EditJournalPageController());
              var page = JournalPage.fromJournalPage(
                journalPage: list[index]!,
              );
              Get.find<EditJournalPageController>().journalPage(page);
              JournalPage? temp = await Get.to(
                () => EditJournalPage(),
              );
              Get.delete<EditJournalPageController>();
              if (temp != null) {
                list[index] = JournalPage.fromJournalPage(
                  journalPage: temp,
                );
                controller.saveToBox(
                  list[index]!.created,
                  list[index],
                  JournalController.journalBoxName,
                );
                updatePages();
              } else {
                print("edit journal page cancelled");
              }
            },
            child: Column(
              children: [
                titleArea,
                contentArea,
              ],
            ),
          ),
        ],
      ),
    );
    return framedContainer;
  }

  void updatePages() {
    final list = controller.journalData.value!.pages;
    listTiles.value = List<Container>.generate(
      list.length,
      (index) => listTile(
        index: index,
      ),
    )..add(
        Container(
          height: 12.0,
        ),
      );
  }

  DateAndTimeFormat dtf = DateAndTimeFormat();

  @override
  Widget build(BuildContext context) {
    updatePages();
    return Scaffold(
      backgroundColor: Colors.white,
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
            "Journal",
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
                color: Colors.black,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: Obx(() {
          return ListView(
            children: listTiles,
          );
        }),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[200]!,
              offset: Offset(0.0, -0.5),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      print("Add page");
                      Get.put(EditJournalPageController());
                      var c = Get.find<EditJournalPageController>();
                      c.journalPage.value = JournalPage();
                      JournalPage? temp = await Get.to(() => EditJournalPage());
                      if (temp != null) {
                        controller.addPage(temp);
                        print("Regular task created");
                      } else {
                        print("No regular task created");
                      }
                      Get.delete<EditJournalPageController>();
                      updatePages();
                    },
                    onLongPress: () {},
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.lightBlueAccent,
                      size: 55,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      await showDialog<int>(
                        context: context,
                        builder: (BuildContext context) {
                          int? temp = sortByOption;
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Sort by"),
                                Spacer(),
                                Icon(
                                  Icons
                                      .add_circle, // MaterialCommunityIcons.sort,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Scrollbar(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('Date created'),
                                          leading: Radio<int>(
                                            value: 0,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Deadline'),
                                          leading: Radio<int>(
                                            value: 1,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Level'),
                                          leading: Radio<int>(
                                            value: 2,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  sortByOption = temp;
                                  Navigator.of(context).pop();
                                },
                                child: Text("Apply"),
                              ),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                      //TodoListCommon.of(context).sortTasksBy(sortByOption);
                      updatePages();
                      print("sorted");
                    },
                    icon: Icon(
                      Icons.add_circle, // MaterialCommunityIcons.sort,
                      color: Colors.black,
                      size: 30,
                    ),
                    tooltip: "Sort by",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      ascendingOrder!
                          ? CommunityMaterialIcons.alpha_a_circle
                          // MaterialCommunityIcons.alpha_a_circle
                          : Icons
                              .add_circle, // MaterialCommunityIcons.alpha_d_circle,
                      color: Colors.blue[800],
                      size: 35,
                    ),
                    onPressed: () {
                      print("sort in ascending or descending");
                      controller.switchListOrder();
                      print(
                          "Order: ${controller.journalData.value!.ascendingOrder! ? "asc" : "desc"}ending");
                      ascendingOrder =
                          controller.journalData.value!.ascendingOrder;
                      updatePages();
                    },
                    tooltip: "Order: ${ascendingOrder! ? "asc" : "desc"}ending",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
