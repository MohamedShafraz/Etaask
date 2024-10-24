import '../database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepository {
  late DatabaseHelper _databaseHelper;
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseHelper.initDatabase();
      return _database;
    }
  }

  TaskRepository() {
    _databaseHelper = DatabaseHelper();
  }

  //Insert Data
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Data
  readData(table) async {
    var connection = await database;
    var data = await connection?.query(table);

    return data;
  }

  //Read Single record by Id
  readDataById(table, contactId) async {
    var connection = await database;
    var data =
        await connection?.query(table, where: 'id=?', whereArgs: [contactId]);
    return data;
  }

  //Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete User
  deleteData(table, contactId) async {
    var connection = await database;
    return await connection
        ?.delete(table, where: 'id=?', whereArgs: [contactId]);
  }
}
