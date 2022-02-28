import 'package:hive/hive.dart';
part 'journal_page.g.dart';

@HiveType(typeId: 3)
class JournalPage extends HiveObject {
  @HiveField(0)
  late DateTime created;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? content;

  @HiveField(3)
  bool? fav;

  JournalPage() {
    created = DateTime.now();
    title = "";
    content = "";
    fav = false;
  }

  JournalPage.fromJournalPage({
    required JournalPage journalPage,
  }) {
    this.created = journalPage.created;
    this.title = journalPage.title;
    this.content = journalPage.content;
    this.fav = journalPage.fav;
  }
}
