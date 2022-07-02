part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class GetMessage extends ChatEvent {
  Message msgToGet;
  GetMessage(this.msgToGet);
}

class SendMessage extends ChatEvent {
  Message msgToSend;
  SendMessage(this.msgToSend);
}

class GetConversation extends ChatEvent {

}


// Im really not familiar with bloc yet, is this fine here?