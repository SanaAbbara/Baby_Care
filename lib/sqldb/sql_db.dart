import 'package:baby_care/model/picture.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BabyCareDb {
  static Database? _db;
  static const String ID = 'id';
  static const String photo_title = 'photo_title';

  static const String photo = 'photo';
  static const String TABLE = 'PhotosTable';
  //for init only one
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    // add path for data base on device
    String dbpath = await getDatabasesPath();

    String path = join(dbpath, 'babyCare.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

//create table for database
  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $TABLE (
  $ID INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
  $photo TEXT NULL,
  $photo_title TEXT NOT NULL 
   
)
''');

    print("on create database and table==============================");
  }

  _onUpgrade(Database db, int version, int newversion) {
    print("on update database and table==============================");
  }

  // select  from database/ pramater sql is talbe name and parameters
  Future<List<Map<dynamic, dynamic>>> readData(String sql) async {
    // for verifiy is data exist or not
    Database? mydb = await db;
    List<Map> response = await mydb!.query(sql);
    return response;
  }

  Future<int> insertData(String sql, Picture picture) async {
    // for verifiy is data exist or not
    Database? mydb = await db;
    int response = await mydb!.insert(sql, picture.toMap());
    return response;
  }

  updateData(String sql) async {
    // for verifiy is data exist or not
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    // for verifiy is data exist or not
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future close() async {
    var dbClient = await _db;
    dbClient!.close();
  }

  Future<List<Picture>> getPhotos() async {
    var dbClient = await _db;
    List<Map<String, dynamic>> maps =
        await dbClient!.query(TABLE, columns: [ID, photo, photo_title]);
    List<Picture> baby = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        baby.add(Picture.fromMap(maps[i]));
      }
    }
    return baby;
  }
}
