import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static final _databaseName = 'sokoDB.db';
  static final _databaseVersion = 1;

  static final table = 'product_tb';
  static final columnID = 'id';
  static final columnProductname = 'productname';
  static final columnDetail = 'detail';
  static final columnAmount = 'amount';
  static final columnRetail = 'retail';
  static final columnWholesale = 'wholesale';
  static final columnCategory = 'category';
  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance =  DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate 
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE Table $table (
        $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnProductname TEXT NOT NULL,
        $columnDetail TEXT,
        $columnAmount INTEGER NOT NULL,
        $columnRetail INTEGER NOT NULL,
        $columnWholesale INTEGER NOT NULL,
        $columnCategory TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<Map<String, dynamic>> getProductData(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> myQueryList = await db.rawQuery('SELECT * FROM $table WHERE $columnID = $id');

    return myQueryList[0];
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async{
    Database db = await instance.database;
    List<Map<String, dynamic>> myQueryList = await db.rawQuery('SELECT * FROM $table');
    return myQueryList;
  }

  Future<int> update(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(table, row,
        where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnID = ?', whereArgs: [id]);
  }
  

}