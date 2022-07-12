// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/apis/database_api.dart';
import 'package:flutter_bloc_socket/apis/socket_api.dart';
import 'package:flutter_bloc_socket/chat_detail.dart';
import 'package:flutter_bloc_socket/models/chat_user.dart';

import 'apis/authentification.dart';
import 'bloc/chat/chat_bloc.dart';

class Chat extends StatefulWidget {
  final String username;
  const Chat(
    @required this.username,
  );

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
 

  // Is this the correct approach here to do it like this?
  late SocketApi socketApi;
  DatabaseApi databaseApi = DatabaseApi.db;
  Auth auth = Auth.instance;


   @override
  void initState() {
    super.initState();

    initSocketApi();
  }

  Future<void> initSocketApi() async {
    socketApi = SocketApi();
    await socketApi.connect();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    

    

    return Scaffold(
      appBar: AppBar(
  // iconTheme: IconThemeData(
  //   color: Colors.black, //change your color here
  // ),
  title: Text("Chatlist of ${auth.currentUser.socketId}"),
  centerTitle: true,
),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.near_me),
      //     onPressed: () async {
      //       // sending the message with socketapi correct?
      //       // Correct!
      //       // here we are sending additional info (fromId toId)
      //       socketApi.sendMessage('', '', 'message');
      //     }),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (BuildContext context, ChatState state) {
                  if (state is ChatInitialState) {
                    context.read<ChatBloc>().add(LoadChatPartnersEvent());
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatPartnersLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatPartnersLoadedState) {
                    return buildChatPartnersList(state.conversationPartners);
                  } else if (state is ChatPartnersErrorState) {
                    return const Center(child: Text('There was an error'));
                  }
                  return const Center(child: Text('something went wrong'));
                },
              ),
              // child:
            ),
            TextButton(onPressed: () async => await databaseApi.testfunction(), child: Text('test')),
            TextButton(onPressed: () async => await databaseApi.addContact(1), child: Text('add contact A')),
            TextButton(onPressed: () async => await databaseApi.addContact(2), child: Text('add contact B')),
            TextButton(onPressed: () async => await databaseApi.addContact(3), child: Text('add contact C')),
            TextButton(onPressed: () async => await databaseApi.getContacts(), child: Text('get contacts')),
          ],
        ),
      ),
    );
  }
}

Widget buildChatPartnersList(List<User> conversationPartners) {
  return ListView.builder(
      itemCount: conversationPartners.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ChatDetail(conversationPartners[index].userName)));
            },
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
                        Text(
                            'socket id: ${conversationPartners[index].socketId}'),
                        Text('id: ${conversationPartners[index].id}'),
                      ],
                    )
                  ]),
            ),
          ),
        );
      }));
}
