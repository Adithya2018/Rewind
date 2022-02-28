import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';

class JournalData {
  final RxList<JournalPage> pages = RxList<JournalPage>();
  final RxBool ascendingOrder = RxBool(true);
  final RxInt sortByOption = RxInt(0);
  final DeepCollectionEquality deepEq = DeepCollectionEquality();
  final List<Function> sortByFunction = [
    (JournalPage a, JournalPage b) => a.created.compareTo(b.created),
    (JournalPage a, JournalPage b) => a.title!.compareTo(b.title!),
  ];
  Set<int>? selected;
  Function get currentSortByFunction => (JournalPage? a, JournalPage? b) =>
      (ascendingOrder.value ? 1 : -1) * sortByFunction[sortByOption.value](a, b)
          as int;

  JournalData({
    List<JournalPage>? pages,
    Set<int>? selected,
    int? sortByOption,
    bool? ascendingOrder,
  }) {
    this.pages(pages);
    this.selected = selected;
    this.sortByOption(sortByOption ?? this.sortByOption.value);
    this.ascendingOrder(ascendingOrder ?? this.ascendingOrder.value);
  }

  // TODO: copy function for JournalData
  /*JournalData copy({
    List<JournalPage?>? pages,
    Set<int>? selected,
    int? sortByOption,
    bool? ascendingOrder,
  }) =>
      JournalData(
        pages: pages ?? this.pages,
        selected: selected ?? this.selected,
        sortByOption: sortByOption ?? this.sortByOption,
        ascendingOrder: ascendingOrder ?? this.ascendingOrder,
      );*/

  /*@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalData &&
          runtimeType == other.runtimeType &&
          deepEq.equals(pages, other.pages) &&
          deepEq.equals(selected, other.selected) &&
          sortByOption == other.sortByOption &&
          ascendingOrder == other.ascendingOrder;

  @override
  int get hashCode => super.hashCode;*/
}
