import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/database_api.dart';
import 'package:flutter_bloc_socket/models/chat_user.dart';
import 'package:flutter_bloc_socket/socket_api.dart';

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
            // Expanded(
            //   child: BlocBuilder<ChatBloc, ChatState>(
            //     builder: (BuildContext context, ChatState state) {
            //       if(state is ChatInitialState){
            //         context.read()<ChatBloc>().add(LoadChatEvent());
            //         return const CircularProgressIndicator();
            //       } else if(state is ChatLoadingState){
            //         return const CircularProgressIndicator();
            //       } else if(state is ChatLoadedState){
            //         return const Text('data loaded');
            //       } else if(state is ChatErrorState){
            //         return const Text('There was an error');
            //       }
            //       return const Text('something went wrong');
            //       // if (state is ChatL) {
            //       //   // <-- You might want to correct the name here!!! State instead of Event... I guess a copy paste trick ;P
            //       //   return ListView.builder(
            //       //     itemCount: state.conversation.length, //<-- get the length
            //       //     itemBuilder: ((context, index) {
            //       //       return Text(
            //       //         state.conversation[index].message.toString(),
            //       //       );
            //       //     }),
            //       //   );
            //       // } else {
            //       //   return const CircularProgressIndicator();
            //       // }
            //     },
            //   ),
            //   // child:
            // ),
          ],
        ),
      ),
    );
  }
}