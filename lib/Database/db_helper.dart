import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  //database name
  static const databaseName = "info.db";
  //database version
  static const databaseVersion = 1;
  //table name
  static const tableInfo = 'student_info';
  //column names
  static const columnId = 'student_id';
  static const columnName = 'student_name';
  static const columnPhone = 'phone';
  static const columnEmail = 'email';
  static const columnLocation = 'Location';



  //create a single instance of DatabaseHelper
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  static Database? myDb;


  //for initializing the database
  Future<Database?> get database async {
    if (myDb != null) return myDb;
    myDb = await initDatabase();
    return myDb;
  }


  //for initializing the database path
  initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
        path,
        version: databaseVersion,
        onCreate: createTables
    );
  }


  //for creating table in database  if not exist already
  Future createTables(Database db, int version) async {

    await db.execute("""
          CREATE TABLE $tableInfo (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPhone TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnLocation TEXT NOT NULL,
          )
          """);
  }

  //for insert data
  Future<int> insertData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableInfo, row);
  }

  //for read data from database
  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await instance.database;

    return await db!.query(tableInfo, orderBy: "$columnId DESC");

    // Use rawQuery to select all notes
    // List<Map<String, dynamic>> notes = await db!.rawQuery('SELECT * FROM notes');

    //return notes;
  }


  //for update data in database
  Future<int> updateData(Map<String, dynamic> row,int id) async {
    Database? db = await instance.database;

    return await db!
        .update(tableInfo, row, where: '$columnId = ?', whereArgs: [id]);

    // await db.rawQuery(
    //     'SELECT * FROM notes WHERE userId = ?',
    //     [userId]);

  }

  //for delete data from database
  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableInfo, where: '$columnId = ?', whereArgs: [id]);
  }
}