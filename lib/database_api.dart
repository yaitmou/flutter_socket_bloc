import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/chat_user.dart';

class DatabaseApi {
  DatabaseApi._();
  static final DatabaseApi db = DatabaseApi._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    print('_init database');
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE ChatUser(id INTEGER PRIMARY KEY, socketId TEXT, userName TEXT);",
        );
      },
      version: 1,
    );
  }

  // Define a function that inserts user into the database
  Future<void> insertUser(ChatUser user) async {
    // // Get a reference to the database.
    // final db = await database;

    Database database = await db.database;

    // Insert the user into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same user is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      'ChatUser',
      ChatUser(userName: user.userName, id: user.id, socketId: user.socketId)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('User created');
  }

// A method that retrieves all the dogs from the dogs table.
  Future<List<ChatUser>> getUsers() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('ChatUser');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ChatUser(
        id: maps[i]['id'],
        socketId: maps[i]['socketId'],
        userName: maps[i]['userName'],
      );
    });
  }

  Future<ChatUser> getUser(userId) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('ChatUser');
    var finalUser;

    final res = await db.query(
      'ChatUser',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    for (var n in res) {
      finalUser = ChatUser.fromMap(n);
    }
    return finalUser;
  }

  Future<void> updateSocketId(ChatUser user) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given user.
    await db.update(
      'ChatUser',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the user's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }
}
