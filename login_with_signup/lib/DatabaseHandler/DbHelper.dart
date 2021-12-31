import 'package:login_with_signup/Model/CarModel.dart';
import 'package:login_with_signup/Model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database _db;

  static const String DB_Name = 'data.db';
  static const String Table_User = 'user';
  static const String Table_Cars = 'cars';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  static const String C_Model = 'model';
  static const String C_Make = 'make';
  static const String C_Description = 'description';
  static const String C_ImageSrc= 'imageSrc';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");
    await db.execute("CREATE TABLE $Table_Cars ("
        " $C_Model TEXT, "
        " $C_Make TEXT, "
        " $C_Description TEXT,"
        " $C_ImageSrc TEXT, "
        " PRIMARY KEY ($C_Model)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserID = '$userId' AND "
        "$C_Password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }

  Future<int> saveCars(CarModel car) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_Cars, car.toMap());
    return res;
  }
  Future<List<CarModel>> getCars() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_Cars");
    if (res.length > 0) {
     List<CarModel> r = res.map((data) => CarModel.fromMap(data)).toList();
      return r;
    }
    return null;
  }

}