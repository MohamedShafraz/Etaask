import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Database initiation
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
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

  // Insert a new task
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  // Fetch all tasks
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db.query('tasks');
    return List.generate(taskMaps.length, (i) {
      return Task.fromMap(taskMaps[i]);
    });
  }

  // Fetch a task by its id
  Future<Task?> getTaskById(int id) async {
    final db = await database;
    print(id);
    // Query the tasks table where the id matches the provided id
    final List<Map<String, dynamic>> taskMaps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Check if a task was found
    if (taskMaps.isNotEmpty) {
      return Task.fromMap(taskMaps.first);
    }

    // Return null if no task was found with the given id
    return null;
  }

  // Update a task
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete a task
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
