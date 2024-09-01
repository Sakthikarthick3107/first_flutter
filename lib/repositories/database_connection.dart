import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  static Database? _database;

  Future<Database> setDatabase() async{
    try {
      if(_database != null) return _database!;
      var directory = await getApplicationDocumentsDirectory();
      var path = join(directory.path , 'build_todo_2.db');
      _database  = await openDatabase(path , version: 1 , onCreate: _onCreatingDatabase);
      return _database!;
    }
    catch (e) {
      print('Error initializing database');
      rethrow;
    }
  }

  Future<void> _onCreatingDatabase(Database database , int version) async{
    try {
      await database.execute('CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)');
    } catch (e) {
      print('Error creating table: $e');
    }
  }
}
