import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class JournalOverview extends StatefulWidget {
  const JournalOverview({Key? key}) : super(key: key);

  @override
  _JournalOverviewState createState() => _JournalOverviewState();
}

class _JournalOverviewState extends State<JournalOverview>
    with AutomaticKeepAliveClientMixin<JournalOverview> {
  DateTime selectedDateTime = DateTime.now();
  DateAndTimeFormat dtf = DateAndTimeFormat();
  Column searchBar() {
    List<Widget> list = [];
    Row searchBar = Row(
      children: [
        Spacer(),
        Text(
          "${dtf.formatDate(selectedDateTime)}",
          style: GoogleFonts.gloriaHallelujah(
            fontSize: 17,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {},
        ),
      ],
    );
    list.add(searchBar);
    Expanded searchResults = Expanded(
      child: Container(
        width: double.maxFinite,
        child: Scrollbar(
          child: ListView(
            shrinkWrap: true,
            children: List<Widget>.generate(5, (index) {
              return Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                height: 100.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New challenge!",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );

    list.add(searchResults);
    list.add(
      SizedBox(
        height: 5.0,
      ),
    );
    Column result = Column(
      children: list,
    );
    return result;
  }

  Column currentEntry() {
    Text title = Text(
      "Title",
      style: GoogleFonts.gloriaHallelujah(
        fontSize: 17,
      ),
    );
    Expanded contentArea = Expanded(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 7.5,
          right: 7.5,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text(
              "The Crafts Mela at Suraj Kund was much more impressive and grand than what I had imagined. This year"
              "the ‘Theme State’ was Rajasthan. The whole campus was painted with the visuals of Ranthambore, Chittor,"
              "Jodhpur and Jaisalmer. It was Mini India assembled on a few hundred acres of land. All the awarded"
              "artisans from different states had set up their workshops and stalls there. Many countries, more particularly"
              "artisans from different states had set up their workshops and stalls there. Many countries, more particularly"
              "artisans from different states had set up their workshops and stalls there. Many countries, more particularly"
              "artisans from different states had set up their workshops and stalls there. Many countries, more particularly"
              "artisans from different states had set up their workshops and stalls there. Many countries, more particularly"
              "Pakistan, Nepal and Afghanistan gave it an international look. Bangles, jewellery decoration pieces, wall-",
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 12,
                color: Color(0xFF0938BC),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
    Column result = Column(
      children: [
        title,
        contentArea,
      ],
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Container journalOverview = Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      constraints: BoxConstraints(
        minHeight: 100.0,
        maxHeight: 200.0,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            height: 45.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Journal",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    print("Open journal");
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 5.0,
                right: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                child: currentEntry(),
                onTap: () {
                  print("Journal");
                  Navigator.of(context).pushNamed('/jou');
                },
              ),
            ),
          ),
        ],
      ),
    );
    return journalOverview;
  }

  @override
  bool get wantKeepAlive => true;
}
