// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_socket/socket_api.dart';
import 'package:meta/meta.dart';

import '../../database_api.dart';
import '../../models/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
final DatabaseApi dbApi;

  ChatBloc(
       this.dbApi,
      )
      : super(ChatInitialState()) {
    on<ChatEvent>((event, emit) {
      if (event is LoadChatEvent) {
        emit(ChatLoadingState());
        //List<Message> apiResult = socketApi. <-- fetch conversation
        // if(apiResult == 0){
        //   emit(ChatErrorState());
        // }
      } else {
        // emit(ChatLoadedState(conversation: conversation))
      }
    });
  }
}
