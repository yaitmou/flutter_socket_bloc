import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/socket_api.dart';

import 'bloc/chat/chat_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Is this the correct approach here to do it like this?
  late SocketApi socketApi;

  @override
  void initState() {
    super.initState();
    // We have already create the bloc in the main. Here, we only once the get
    // a reference to it
    SocketApi(context.read<ChatBloc>());
    socketApi.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.near_me),
          onPressed: () {
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
                  // At This point im still struggling getting the data in real time
                  // im not sure if chatbloc in bloc above is fine
                  // im not sure how to call the messages and messages length below here
                  if (state is GetConversationEvent) {
                    // <-- You might want to correct the name here!!! State instead of Event... I guess a copy paste trick ;P
                    return ListView.builder(
                      itemCount: state.conversation.length, //<-- get the length
                      itemBuilder: ((context, index) {
                        return Text(
                          state.conversation[index].message.toString(),
                        );
                      }),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
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
