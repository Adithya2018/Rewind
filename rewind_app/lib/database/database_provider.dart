/*import 'package:path/path.dart';
import 'package:rewind_app/tables/table_goals.dart';
import 'package:rewind_app/tables/table_routine.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const TableGoals TABLE_GOALS = TableGoals();

  static const TableRoutine TABLE_ROUTINE = TableRoutine();

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("get database function");
    if (_database != null) {
      return _database;
    }
    _database = await createDB();
    return _database;
  }

  Future<void> deleteDB() async {
    print("getting path");
    String dbPath = await getDatabasesPath();
    await ((await openDatabase(
        join(dbPath, 'sampleDB.db'),
    ))
        .close());
    print("closing");
    await deleteDatabase(
    join(dbPath, 'sampleDB.db'),
    );
    print("deleting");
  }

  Future<Database> createDB() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'sampleDB.db'),
      version: 1,
      onCreate: (database, version) async {
        print("creating table");
        await database.execute(
          "CREATE TABLE $TABLE_GOALS ("
         /* "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_LABEL TEXT,"
          "$COLUMN_DESCRIPTION TEXT"*/
          ")",
        );
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    var query = await db.query(
      TABLE_GOALS.TABLE_GOALS,
      columns: [
        /*COLUMN_ID,
        COLUMN_LABEL,
        COLUMN_DESCRIPTION,*/
      ],
    );
    List<Task> result = [];
    query.forEach((element) {
      Task task = Task.fromMap(element);
      result.add(task);
    });
    return result;
  }

  Future<Task> insert(Task task) async {
    final db = await database;
    task.orderIndex = await db.insert(
      TABLE_GOALS.TABLE_GOALS,
      task.toMap(),
    );
    return task;
  }


  Future<List<RegularTask>> getRegularTasks() async {
    final db = await database;
    var query = await db.query(
      TABLE_GOALS.TABLE_GOALS,
      columns: [
        /*COLUMN_ID,
        COLUMN_LABEL,
        COLUMN_DESCRIPTION,*/
      ],
    );
    List<RegularTask> result = [];
    query.forEach((element) {
      RegularTask t = RegularTask.fromMap(element);
      result.add(t);
    });
    return result;
  }
}
*/
