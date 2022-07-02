import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];

  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>((event, emit) {
      // TODO: implement event handler
      messages.add(event.msgToSend);
      emit(GetConversationEvent(messages));
    });

    on<GetMessage>((event, emit) {
      // message socket event is getting called, then the GetMessage in here is called and I can see the message in the express server console
      print('bloc getmessage called');
      var message = event.msgToGet;

      // I can also see this message here
      print(message);
      messages.add(message);
      emit(GetConversationEvent(messages));
    });

    on<GetConversation>((event, emit) {
      // TODO: implement event handler
      emit(GetConversationEvent(messages));
    });
  }

  // Im really not familiar with bloc yet, is this fine here?

}
