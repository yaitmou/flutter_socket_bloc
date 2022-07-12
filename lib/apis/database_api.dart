import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../bloc/chat/chat_bloc.dart';
import '../models/chat_user.dart';
import 'authentification.dart';

class DatabaseApi {
  DatabaseApi._();
  static final DatabaseApi db = DatabaseApi._();

  // static Database? _database;
  // Future<Database> get database async => _database ??= await initDB();



  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initDB();

   Auth auth = Auth.instance;

  // static User? _authUser;
  // Future<User> get authUser async => user;




  Future<Database> initDB() async {
    print('_init database');
    return await openDatabase(
      join(await getDatabasesPath(), 'database24.db'),
      // onConfigure: _onConfigure,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE chatuser(id INTEGER PRIMARY KEY, socketId TEXT, userName TEXT);",
        );
        db.execute(
          "CREATE TABLE contacts(userId INTEGER, partnerId INTEGER);",
        );
      },
      version: 1,
    );
  }

//   static Future _onConfigure(Database db) async {
//     await db.execute('PRAGMA foreign_keys = ON');
// }

  // Define a function that inserts user into the database
  Future<void> insertUser(User user) async {
    // // Get a reference to the database.
    // final db = await database;

    Database database = await db.database;

    // Insert the user into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same user is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      'chatuser',
      User(userName: user.userName, id: user.id, socketId: user.socketId)
          .toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('User created');
  }

// A method that retrieves all the dogs from the dogs table.
  Future<List<User>> getUsers() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('chatuser');

   

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    final res = List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        socketId: maps[i]['socketId'],
        userName: maps[i]['userName'],
      );
    });
    return res;
  }

  Future<User> getUserById(userId) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('chatuser');
    var finalUser;

    final res = await db.query(
      'ChatUser',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    for (var n in res) {
      finalUser = User.fromMap(n);
    }
    return finalUser;
  }

  Future<User> getUserByName(String userName) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('chatuser');
    var finalUser;

    final res = await db.query(
      'chatuser',
      where: 'userName = ?',
      whereArgs: [userName],
      limit: 1,
    );
    for (var n in res) {
      finalUser = User.fromMap(n);
    }
    return finalUser;
  }

  Future<void> updateSocketId(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given user.
    await db.update(
      'chatuser',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the user's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
    auth.updateCurrentUserInstance(user);
    print('updatesocketid done: ${user.id} ++ ${auth.currentUser}');
  }

  Future<void> testfunction() async {
    print('testfunction says : ${auth.currentUser}');
final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM contacts');

    final res = List.generate(maps.length, (i) {
      return print(maps[i].entries);
    });
    print(res);
   

  }

  Future<void> addContact(int partnerId) async {
    final db = await database;

    
    
     await db.insert(
      'contacts',
      {'userId': auth.currentUser.id,
      'partnerId': partnerId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.insert(
      'contacts',
      {'userId':partnerId,
      'partnerId':  auth.currentUser.id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getContacts() async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query('ChatUser');
    //var contacts;
    // rawQuery('SELECT * FROM chatuser WHERE id = (SELECT partnerId FROM contacts WHERE chatuser_id = ${auth.currentUser.id})');

final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM chatuser JOIN contacts ON chatuser.id = contacts.userId WHERE contacts.partnerId = ${auth.currentUser.id}');
 //print('map print $maps');
    final res = List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        socketId: maps[i]['socketId'],
        userName: maps[i]['userName'],
      );
    });
   // print(res);
    return res;
    
  }
}
