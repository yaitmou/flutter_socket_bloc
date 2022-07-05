/// You might want to create a chat user
///
/// Basic information would be required the most important property here is the
/// [socketId]. We send this to server so that we can send targeted chat
/// messages to each user
///
/// ChatUser({
///   this.socketId,
///   this.id,
///   this.userName,
///   this.isOnline,
/// });
///

class ChatUser {
  int id;
  String socketId;
  String userName;
  // String isOnline;

  ChatUser({
    required this.id,
    required this.socketId,
    required this.userName,
    // required this.isOnline
  });

// Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'socketId': socketId,
      'userName': userName,
    };
  }

 
   factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'] as int,
      socketId: map['socketId'] as String,
      userName: map['userName'] as String,
    );
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, socketId: $socketId, userName: $userName}';
  }
}
