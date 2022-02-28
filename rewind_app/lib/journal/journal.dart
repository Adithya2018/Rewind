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
  final DateTimeFormat dtf = DateTimeFormat();
  final RxList<Container> listTiles = RxList();

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

  Container listTile(int index) {
    final list = controller.journalData.pages;
    DateTime created = list[index].created;
    TimeOfDay timeOfDay = TimeOfDay(
      hour: created.hour,
      minute: created.minute,
    );
    Container dateTimeContainer = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${dtf.formatDate(
              created,
              abbr: true,
            )}",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Spacer(),
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
        list[index].title!,
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
        list[index].content!.isEmpty ? "<no content>" : list[index].content!,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 12,
          color: Colors.black,
        ),
        maxLines: 3,
      ),
    );
    Container result = Container(
      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
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
          dateTimeContainer,
          GestureDetector(
            onTap: () async {
              Get.put(EditJournalPageController());
              var page = JournalPage.fromJournalPage(
                journalPage: list[index],
              );
              Get.find<EditJournalPageController>().journalPage(page);
              Get.find<EditJournalPageController>().fav(page.fav);
              JournalPage? temp = await Get.to(
                () => EditJournalPage(),
              );
              Get.delete<EditJournalPageController>();
              print('ifdvoi');
              if (temp != null) {
                list[index] = JournalPage.fromJournalPage(
                  journalPage: temp,
                );
                controller.saveToBox(
                  list[index].created,
                  list[index],
                  JournalController.journalBoxName,
                );
                listTiles[index] = listTile(
                  index,
                );
              } else {
                print("edit journal page cancelled");
              }
              updatePages();
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
    return result;
  }

  void updatePages() {
    final list = controller.journalData.pages;
    listTiles.value = List<Container>.generate(
      list.length,
      (index) => listTile(
        index,
      ),
    )..add(
        Container(
          height: 12.0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
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
        ),
      ),
      body: Scrollbar(
        child: Obx(
          () {
            updatePages();
            print('updating page list');
            return ListView(
              children: listTiles,
            );
          },
        ),
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
                      Get.find<EditJournalPageController>().journalPage(
                        JournalPage(),
                      );
                      JournalPage? temp = await Get.to(
                        () => EditJournalPage(),
                      );
                      if (temp != null) {
                        controller.addPage(temp);
                        print("Regular page created");
                      } else {
                        print("No page created");
                      }
                      Get.delete<EditJournalPageController>();
                    },
                    onLongPress: () {
                      print('long pressed');
                    },
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
                      int temp = controller
                          .journalData.sortByOption.value;
                      await showDialog<int>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Sort by",
                                ),
                                Spacer(),
                                Icon(
                                  CommunityMaterialIcons.sort,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            content: Obx(() {
                              return Scrollbar(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          'Date created',
                                        ),
                                        leading: Radio<int>(
                                          value: 0,
                                          groupValue: controller
                                              .journalData.sortByOption.value,
                                          onChanged: (value) {
                                            print('Sort by: Date created');
                                            controller.journalData
                                                .sortByOption(value);
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Title',
                                        ),
                                        leading: Radio<int>(
                                          value: 1,
                                          groupValue: controller
                                              .journalData.sortByOption.value,
                                          onChanged: (value) {
                                            print('Sort by: Title');
                                            controller.journalData
                                                .sortByOption(value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  print('apply button');
                                  controller.sortPages();
                                  updatePages();
                                  Get.back();
                                },
                                child: Text("Apply"),
                              ),
                              TextButton(
                                onPressed: () {
                                  print('cancel button');
                                  controller.journalData
                                      .sortByOption(temp);
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CommunityMaterialIcons.sort,
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
                    icon: Obx(() {
                      return Icon(
                        controller.journalData.ascendingOrder.value
                            ? CommunityMaterialIcons.alpha_a_circle
                            : CommunityMaterialIcons.alpha_d_circle,
                        color: Colors.blue[800],
                        size: 35,
                      );
                    }),
                    onPressed: () {
                      print("sort button gkdjgk");
                      controller.switchListOrder();
                      print(
                          "Order: ${controller.journalData.ascendingOrder.value ? "asc" : "desc"}ending");
                      updatePages();
                    },
                    tooltip:
                        "Order: ${controller.journalData.ascendingOrder.value ? "Asc" : "Asc"}ending",
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
