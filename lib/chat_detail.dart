import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/apis/authentification.dart';

import 'apis/socket_api.dart';
import 'bloc/chat/chat_bloc.dart';
import 'models/chat_message.dart';
import 'models/chat_user.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail(final this.userName, {Key? key}) : super(key: key);
  final String userName;

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {

    late SocketApi socketApi;
    Auth auth = Auth.instance;

    @override
  void initState() {
    super.initState();

socketApi = SocketApi();
    // Start listening to changes.
  myController.addListener(_printLatestValue);
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
  print('Second text field: ${myController.text}');
}

  @override
  Widget build(BuildContext context) {

    Future<void> sendMessage() async {
      final User toUser = await socketApi.chatBloc.dbApi.getUserByName(widget.userName);
      print(toUser.socketId);
      socketApi.sendMessage(auth.currentUser.socketId, toUser.socketId, myController.text);
      setState(() { myController.clear(); });
    }

    
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(widget.userName),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendMessage(),
        child: Icon(Icons.send),),
        body: Column(
          children: [
          // Spacer(),
          BlocBuilder<ChatBloc, ChatState>(
                builder: (BuildContext context, ChatState state) {
                  if (state is ChatInitialState) {
                    context.read<ChatBloc>().add(LoadConversationEvent());
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConversationLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConversationLoadedState) {
                    return buildConversation(state.conversation);
                  } else if (state is ConversationErrorState) {
                    return const Center(child: Text('There was an error'));
                  }
                  return const Center(child: Text('something went wrong'));
                },
              ),
              Spacer(),
          Container(
            width: 280,
            padding: EdgeInsets.fromLTRB(0, 0, 30, 45),
            alignment: Alignment.bottomCenter,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter message',
                      ),
                    ),
                  ),
        ]),
      // body: const Center(
      //   child: Text('Silence here at the moment'),
      // ),
    );
  }
}

Widget buildConversation(List<Message> conversation) {
  return ListView.builder(
    shrinkWrap: true,
      itemCount: conversation.length,
      itemBuilder: ((context, index) {
        return Container(
              height: 100,
              color: Colors.grey.withOpacity(0.2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(conversation[index].message),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Text(
                    //         'socket id: ${conversationPartners[index].socketId}'),
                    //     Text('id: ${conversationPartners[index].id}'),
                    //   ],
                    // )
                  ]),
          
          
        );
      }));
}
