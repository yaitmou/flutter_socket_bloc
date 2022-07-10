part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}
// ----------------------------------


// // Chat Loading Events
// class ChatLoadingState extends ChatState {}

// class ChatLoadedState extends ChatState {
//   List<Message> conversation;
//   ChatLoadedState({required this.conversation});
// }

// class ChatErrorState {}

// ChatPartner Events
class ChatPartnersLoadingState extends ChatState {}

class ChatPartnersLoadedState extends ChatState {
  List<User> conversationPartners;
  ChatPartnersLoadedState({required this.conversationPartners});
}

class ChatPartnersErrorState {}

// Chat Conversation Events
class ConversationLoadingState extends ChatState {}

class ConversationLoadedState extends ChatState {
  List<Message> conversation;
  ConversationLoadedState({required this.conversation});
}

class ConversationErrorState {}