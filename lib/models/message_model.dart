// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

///
/// !!!!!!
/// I would really recommend using Freezed package for less verbosity :s
/// !!!!!!
///
class Message {
  String timestamp;
  String message;
  // You need to keep track on who are discussing!!! check the chat_user.dart
  // ChatUser sender
  // ChatUser receiver
  String id;
  Message({
    required this.timestamp,
    required this.message,
    required this.id,
  });

  Message copyWith({
    String? timestamp,
    String? message,
    String? id,
  }) {
    return Message(
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'message': message,
      'id': id,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      timestamp: map['timestamp'] as String,
      message: map['message'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Message(timestamp: $timestamp, message: $message, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.timestamp == timestamp &&
        other.message == message &&
        other.id == id;
  }

  @override
  int get hashCode => timestamp.hashCode ^ message.hashCode ^ id.hashCode;
}
