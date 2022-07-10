import 'package:flutter_bloc_socket/apis/database_api.dart';

import '../models/chat_user.dart';

class Auth {
  late User currentUser;
  Auth._();
  static final Auth auth = Auth._();

  Future<User> get curruser async => currentUser;

  Future<User> authenticate(String username) async {
    currentUser = await DatabaseApi.db.getUserByName(username);
    print('authenticate : $currentUser');
    return currentUser;
  }
}