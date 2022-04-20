// We will start with the import of necessary package,

import 'dart:async';
import 'package:desktop/model/model_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// to define variables
final String itemsTable = "itemsTable";
final String idColumn = "idColumn";
final String matriculeColumn = "matriculeColumn";
final String tagIdColumn = "tagIdColumn";
final String imgColumn = "imgColumn";

// In this SqlHelper class, we will create a method to manipulate the data.
class SqlHelper {
  // to define the variables

  static final SqlHelper _instance = SqlHelper.internal();
  factory SqlHelper() => _instance;

  SqlHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      // _db != null -> update an existing item
      return _db;
    } else {
      // _db == null -> create new item
      _db = await initDb();

      return _db;
    }
  }

// to initialize the database
  Future<Database> initDb() async {
    // Get a location using getDatabasesPath ///
    final databasesPath = await getDatabasesPath();
    // Set your path to the database.
    final path = join(databasesPath, "brhom5.db");
    // to Opening a database path ///
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          // when creating the db, create the items table with id PRIMARY KEY , matricule Text,tagId TEXT,and img TEXT ///
          await db.execute("CREATE TABLE $itemsTable("
              "$idColumn INTEGER PRIMARY KEY, "
              "$matriculeColumn TEXT, "
              "$tagIdColumn TEXT,"
              "$imgColumn TEXT)");
        });
  }

  // to add and save the data
  Future<Data> insertData(Data data) async {
    Database dbData = await db;
    // we use insert from sqflite package to add data to Database
    // and convert data to map
    data.id = await dbData.insert(itemsTable, data.toMap());
    return data;
  }

  // to read   data from item table
  Future<Data> readingData(int id) async {
    // Get a reference to the database.
    Database dbData = await db;
    // use query function to view all data to users
    // then Convert the List<Map> into a List<itemsTable>.
    List<Map> maps = await dbData.query(itemsTable,
        columns: [
          idColumn,
          matriculeColumn,
          tagIdColumn,
          imgColumn,
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Data.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // to update the data
  Future<int> updateData(Data data) async {
    Database dbData = await db;
    // to Update the given data should convert data  to map
    return await dbData.update(itemsTable, data.toMap(),
        //Ensure that the Data has a matching id.
        where: "idColumn = ?",
        // Pass the data id as a whereArg to prevent SQL injection.
        whereArgs: [data.id]);
  }

  // to Delete the data
  Future<int> deleteData(int id) async {
    Database dbData = await db;
    return await dbData.delete(itemsTable,
        // Use a `where` clause to add a specific Data.
        where: "$idColumn = ?",
        // Pass the data id as a whereArg to prevent SQL injection.
        whereArgs: [id]);
  }

  // to show all Data form Table:
  Future<List> getData() async {
    Database dbData = await db;
    List listMap = await dbData.rawQuery("SELECT * FROM $itemsTable");
    List<Data> listData = List();
    for (Map m in listMap) {
      listData.add(Data.fromMap(m));
    }
    return listData;
  }

  // to get number of data
  Future<int> getNumber() async {
    Database dbData = await db;
    return Sqflite.firstIntValue(
        await dbData.rawQuery("SELECT COUNT(*) FROM $itemsTable"));
  }

  // to close the data
  Future close() async {
    Database dbData = await db;
    dbData.close();
  }
}
