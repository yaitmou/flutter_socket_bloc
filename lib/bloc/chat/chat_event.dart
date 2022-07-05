part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChatEvent extends ChatEvent {}

class LoadChatPartnersEvent extends ChatEvent{}

