

import 'package:todo_sqlite/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  late DatabaseConnection _databaseConnection;
  Database? _database;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  Future<int> insertData(String table ,  Map<String, dynamic> data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> readData(table) async{
    var connection = await database;
    return await connection.query(table);
  }

  Future<List<Map<String, dynamic>>> readDataById(table , id) async{
    var connection = await database;
    return await connection.query(table , where: 'id = ?' , whereArgs: [id]);
  }

  updateData(String table, data) async{
    var connection = await database;
    return await connection.update(table, data , where: 'id = ?' , whereArgs: [data['id']]);
  }

  deleteData(String table, int categoryId) async{
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $categoryId");
  }

}