import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static late Database _databaseTemporal;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database ?? _databaseTemporal;
    }
    //_database  = await createBD();
    return await createBD();
  }

  Future<Database> createBD() async {
    //1.- Obtener la ruta donde esta instalada nuestra app
    Directory documentDirectoryApp = await getApplicationDocumentsDirectory();
    //2.- Definir la ruta donde va ser creada nuestra BD
    final path = join(documentDirectoryApp.path, "Valtx.db");
    print(path);
    //3.- Crear nuestra BD y Tablas
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Links (
          id INTEGER PRIMARY KEY, 
          name TEXT
        )
        ''');

      await db.execute('''
        CREATE TABLE User (
          id INTEGER PRIMARY KEY, 
          name TEXT,
          lastName TEXT,
          status TEXT
        )
        ''');
    });
  }

  Future<int> insertLink(String link) async {
    final db = await database;
    final response = db.insert("Links", {"name": link},);
    return response;
  }
}
