class JournalPage{
  DateTime? created;
  String? title;
  String? content;
  DateTime? get createdDateTime => created == null ? DateTime.now() : created;

  JournalPage(){
    created = createdDateTime;
    title = "";
    content = "";
  }
}