import 'package:flutter_bloc_socket/apis/database_api.dart';

import '../models/chat_user.dart';

class Auth {
  User currentUser = User.empty;
  Auth._();
  static final Auth auth = Auth._();

  Future<User> get curruser async => currentUser;

  Future<User> authenticate(String username) async {
    print('authenticate username $username');
    currentUser = await DatabaseApi.db.getUserByName(username);
    print('authenticate currentuser : $currentUser');
    return currentUser;
  }
}