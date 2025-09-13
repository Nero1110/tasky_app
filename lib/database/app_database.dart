import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static AppDatabase instance = AppDatabase._private();
  static String tablename = "tasks";
  AppDatabase._private();

  Database? _database;

  factory AppDatabase() {
    return AppDatabase._private();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _open();
    return _database!;
  }

  _open() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, "todos.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
CREATE TABLE $tablename(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT NOT NULL,
description TEXT NOT NULL,
createdAt INTEGER ,
isDone INTEGER default 0
)
''');
      },
    );
  }

   insertdata(TaskModel model) async {
    final db = await database;
    await db.insert(tablename, model.tojson());
  }

  Future<List<TaskModel>> showdata() async {
    final db = await database;
    final rows = await db.query(tablename);
    return rows.map((e) => TaskModel.fromjson(e)).toList();
  }

   Future<int> updateTask(TaskModel model) async {
    final db = await database;
    return await db.update(
      "tasks",                        
      model.tojson(),
      where: "id = ?",            
      whereArgs: [model.id],               
    );
  }

}
