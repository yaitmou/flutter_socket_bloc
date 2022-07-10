class Message {
  String fromUserId;
  String toUserId;
  String message;
  //List<Message>? contacts;
  // String isOnline;
  Message({
    required this.fromUserId,
    required this.toUserId,
    required this.message,
  });

// Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'message': message,
    };
  }

 
   factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      fromUserId: map['fromUserId'] as String,
      toUserId: map['toUserId'] as String,
      message: map['message'] as String,
    );
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Message{id: $fromUserId, socketId: $toUserId, userName: $message}';
  }
}
