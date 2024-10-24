import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tasks');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT, isCompleted INTEGER)',
        );
      },
    );
  }
}
