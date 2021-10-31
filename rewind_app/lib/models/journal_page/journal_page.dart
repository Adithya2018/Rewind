import 'package:hive/hive.dart';
part 'journal_page.g.dart';

@HiveType(typeId: 3)
class JournalPage extends HiveObject {
  @HiveField(0)
  DateTime? created;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? content;

  @HiveField(3)
  bool? fav;
  DateTime? get createdDateTime => created == null ? DateTime.now() : created;

  JournalPage() {
    created = createdDateTime;
    title = "";
    content = "";
    fav = false;
  }

  JournalPage.fromJournalPage(JournalPage temp) {
    this.created = temp.created;
    this.title = temp.title;
    this.content = temp.content;
    this.fav = temp.fav;
  }
}
