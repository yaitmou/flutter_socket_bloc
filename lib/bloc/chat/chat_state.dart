part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  List<Message> conversation;
  ChatLoadedState({required this.conversation});
}

class ChatErrorState {}