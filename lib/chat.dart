import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/apis/database_api.dart';
import 'package:flutter_bloc_socket/models/chat_user.dart';
import 'package:flutter_bloc_socket/apis/socket_api.dart';

import 'bloc/chat/chat_bloc.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // Is this the correct approach here to do it like this?
  late SocketApi socketApi;
  DatabaseApi databaseApi = DatabaseApi.db;
  late ChatUser user;
  var currentUser;


  @override
  Widget build(BuildContext context) {

    getUser() async {
    currentUser = await databaseApi.getUser(1);
    print('User print : ${currentUser}');
    return currentUser;
  }

  getUser().then((value) {
    print(value);
    socketApi = SocketApi(context.read<ChatBloc>(), value);
    socketApi.connect();
  },);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.near_me),
          onPressed: () async {
            // sending the message with socketapi correct?
            // Correct!
            // here we are sending additional info (fromId toId)
            socketApi.sendMessage('', '', 'message');

          }),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (BuildContext context, ChatState state) {
                  if(state is ChatInitialState){
                    context.read<ChatBloc>().add(LoadChatPartnersEvent());
                    return const Center(child: CircularProgressIndicator());
                  } else if(state is ChatPartnersLoadingState){
                    return const Center(child: CircularProgressIndicator());
                  } else if(state is ChatPartnersLoadedState){
                    return buildChatPartnersList(state.conversationPartners);
                  } else if(state is ChatPartnersErrorState){
                    return const Center(child: Text('There was an error'));
                  }
                  return const Center(child: Text('something went wrong'));
                },
              ),
              // child:
            ),
          ],
        ),
      ),
    );
  }
}


Widget buildChatPartnersList(List<ChatUser> conversationPartners) {
  return ListView.builder(
    itemCount: conversationPartners.length,
    itemBuilder: ((context, index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        height: 100,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
        Text(conversationPartners[index].userName),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Text('socket id: ${conversationPartners[index].socketId}'),
          Text('id: ${conversationPartners[index].id}'),
        ],)
        ]),),
    );
  }));
}