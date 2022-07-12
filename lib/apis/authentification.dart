import 'package:flutter_bloc_socket/apis/database_api.dart';

import '../models/chat_user.dart';

// class Auth {
//   User currentUser = User.empty;
//   Auth._();
//   static final Auth auth = Auth._();

//   Future<User> get curruser async => currentUser;

//   Future<User> authenticate(String username) async {
//     print('authenticate username $username');
//     currentUser = await DatabaseApi.db.getUserByName(username);
//     print('authenticate currentuser : $currentUser');
//     return currentUser;
//   }
// }



/// By making the constructor private, we ensure that the class cannot be instantiated outside the file where it is defined.
/// And as a result, the only way to access it is to call Singleton.instance in our code.
/// In some cases, it's preferable to use a static getter variable. For alternative ways of implementing a singleton in Dart, read this thread on StackOverflow.
/// https://codewithandrea.com/articles/flutter-singletons/
/// How to Implement a Singleton in Dart
/// This is the simplest way:

class Auth {
  /// private constructor
  Auth._();
  /// the one and only instance of this singleton
  static final instance = Auth._();
  
  // Create a User instance. Actually it would be better if this is empty so I can notice if a user is valid or not and can react by checking if the user has values and
  // if not log the user out later on
  User currentUser = User(id: 0, socketId: 'socketId', userName: 'userName');

  updateCurrentUserInstance(User user) async {
    currentUser = user;
    print('updateCurrentUserInstance $currentUser');
      //print('auth.currentUser after currentuserinstance ${instance.currentUser}');
    //return currentUser;
  }
}
