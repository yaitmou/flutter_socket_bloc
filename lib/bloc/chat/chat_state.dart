part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetConversationEvent extends ChatState {
  List<Message> conversation;
  GetConversationEvent(this.conversation);
}

// Im really not familiar with bloc yet, is this fine here?