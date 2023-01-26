import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_contacts/data/local/cached_user.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("contacts.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE $userTable (
    ${CachedUsersFields.id} $idType,
    ${CachedUsersFields.userName} $textType,
    ${CachedUsersFields.phoneNumber} $textType
    )
    ''');
  }

  LocalDatabase._init();

  //-------------------------------------------Cached Users Table------------------------------------

  static Future<CachedUser> insertCachedUser(CachedUser cachedUser) async {
    final db = await getInstance.database;
    final id = await db.insert(userTable, cachedUser.toJson());
    print("object");
    return cachedUser.copyWith(id: id);
  }

  static Future<CachedUser> getSingleUserById(int id) async {
    final db = await getInstance.database;
    final results = await db.query(
      userTable,
      columns: CachedUsersFields.values,
      where: '${CachedUsersFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedUser.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedUser>> getAllCachedUsers() async {
    final db = await getInstance.database;
    const orderBy = "${CachedUsersFields.userName} ASC";
    final result = await db.query(
      userTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedUser.fromJson(json)).toList();
  }

  static Future<int> deleteCachedUserById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(userTable, where: "${CachedUsersFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      print("DELETED");
      return t;
    } else {
      print("DELETED");
      return -1;
    }
  }

  static Future<CachedUser> updateCachedUser(CachedUser contactModel) async {
    Map<String, dynamic> col = {
      CachedUsersFields.userName: contactModel.userName,
      CachedUsersFields.phoneNumber: contactModel.phoneNumber,
    };

    final db = await getInstance.database;
    int id =  await db.update(
      userTable,
      col,
      where: '${CachedUsersFields.id} = ?',
      whereArgs: [contactModel.id],
    );
    return contactModel.copyWith(id: id);
  }

  static Future<int> deleteAllCachedUsers() async {
    final db = await getInstance.database;

    return await db.delete(userTable);
  }
}
