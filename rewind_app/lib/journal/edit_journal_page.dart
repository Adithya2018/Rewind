import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/controllers/edit_journal_page_ctrl.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class EditJournalPage extends GetWidget<EditJournalPageController> {
  late final TextEditingController titleFieldCtrl;
  late final TextEditingController contentFieldCtrl;

  final DateAndTimeFormat dtf = DateAndTimeFormat();

  Container textField({
    required BuildContext context,
    required FocusNode focusNode,
    required String labelText,
    required TextEditingController controller,
    required TextInputType textInputType,
    required int? maxLines,
    required bool expands,
    required String hintText,
  }) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: Scrollbar(
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          expands: expands,
          maxLines: maxLines,
          minLines: null,
          keyboardType: textInputType,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: Colors.blueGrey,
          style: GoogleFonts.gloriaHallelujah(
            fontSize: 16,
            color: Color(0xFF0938BC),
          ),
          decoration: InputDecoration(
            hintText: hintText, // "Write something",
            //labelText: labelText,
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Future<void> showErrorMessage(
      {required BuildContext context, String? title, String? msg}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: Colors.red,
                size: 35.0,
              ),
              Text(
                title ?? "Try again",
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Container(
            child: Text(
              msg!,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 16,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;
    print("widget build");
    Container dateTime = Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      alignment: Alignment.centerRight,
      child: Text(
        "${dtf.formatTime(
          TimeOfDay(
            hour: hour,
            minute: minute,
          ),
        )} ${dtf.formatDate(now)}",
        textAlign: TextAlign.end,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 14,
        ),
      ),
    );

    /*Container contentArea = Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: Scrollbar(
        child: TextField(
          controller: contentFieldCtrl,
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: Colors.blueGrey,
          style: GoogleFonts.gloriaHallelujah(
            fontSize: 16,
            color: Color(0xFF0938BC),
          ),
          decoration: InputDecoration(
            hintText: "Write something",
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );*/

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
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.journalPage.value!.fav!
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: Colors.pinkAccent,
                  size: 30.0,
                ),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                tooltip:
                    '${controller.journalPage.value!.fav! ? "Remove from" : "Add to"} favorites',
                onPressed: () {
                  // TODO: change set favorite on tap
                  controller.journalPage.value!.fav =
                      !controller.journalPage.value!.fav!;
                  print("");
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30.0,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              tooltip: 'Delete',
              onPressed: () {
                print("delete page");
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<EditJournalPageController>(
        initState: (state) {
          titleFieldCtrl = TextEditingController(
            text: controller.journalPage.value!.title,
          );
          print('title: ${controller.journalPage.value!.title}');
          contentFieldCtrl = TextEditingController(
            text: controller.journalPage.value!.content,
          );
          print('content: ${controller.journalPage.value!.content}');
        },
        builder: (controller) {
          return Column(
            children: <Widget>[
              dateTime,
              textField(
                context: context,
                focusNode: FocusNode(),
                labelText: 'Title',
                controller: titleFieldCtrl,
                textInputType: TextInputType.text,
                maxLines: 1,
                expands: false,
                hintText: 'Title',
              ),
              Expanded(
                child: textField(
                  context: context,
                  focusNode: FocusNode(),
                  labelText: 'Write something',
                  controller: contentFieldCtrl,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                  hintText: 'Write something',
                  expands: true,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0.0, -1.0),
              blurRadius: 7.0,
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
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      print("Save");
                      if (titleFieldCtrl.text.isEmpty) {
                        await showErrorMessage(
                          context: context,
                          msg: "Title cannot be empty",
                        );
                        return;
                      }
                      controller.journalPage.value!.title = titleFieldCtrl.text;
                      controller.journalPage.value!.content =
                          contentFieldCtrl.text;
                      Get.back(
                        result: controller.journalPage.value,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      print("Cancel");
                      Navigator.pop(context, null);
                    },
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
