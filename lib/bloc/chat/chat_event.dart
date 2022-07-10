// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChatEvent extends ChatEvent {}

class LoadChatPartnersEvent extends ChatEvent{}

class LoadConversationEvent extends ChatEvent{}

class ConversationAddMessageToConversationEvent extends ChatEvent {
   Message message;
  ConversationAddMessageToConversationEvent({
    required this.message,
  });
}

