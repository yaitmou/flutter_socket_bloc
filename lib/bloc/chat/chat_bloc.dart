// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_socket/apis/socket_api.dart';
import 'package:meta/meta.dart';

import '../../apis/database_api.dart';
import '../../models/chat_message.dart';
import '../../models/chat_user.dart';


part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseApi dbApi;
  List<Message> messageList = [];

  ChatBloc(this.dbApi) : super(ChatInitialState()) {
    on<ChatEvent>((event, emit) async {
      if (event is LoadChatEvent) {
        //emit(ChatLoadingState());
        //List<Message> apiResult = socketApi. <-- fetch conversation
        // if(apiResult == 0){
        //   emit(ChatErrorState());
        // }
      } else if (event is LoadChatPartnersEvent) {
        emit(ChatPartnersLoadingState());
        List<User> apiResult = await dbApi.getContacts();
        print('chatbloc user list: ${apiResult}');
        // if(apiResult == 0){
        //   emit(ChatPartnersErrorState());
        // }
        emit(ChatPartnersLoadedState(conversationPartners: apiResult));
      } else if (event is LoadConversationEvent) {
        emit(ConversationLoadingState());
        List<Message> apiResult = [];
        print('chatbloc conversation : ${apiResult}');
      } else if (event is ConversationAddMessageToConversationEvent) {
        emit(ConversationLoadingState());
        messageList.add(event.message);
        emit(ConversationLoadedState(conversation: messageList));
      } else {}
    });
  }
}
