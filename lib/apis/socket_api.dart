import 'package:flutter_bloc_socket/apis/database_api.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../bloc/chat/chat_bloc.dart';
import '../models/chat_message.dart';
import '../models/chat_user.dart';
import 'dart:io' show Platform;

import 'authentification.dart';


// In this file it would help me a lot if you could explain me each line, since
// im not really understanding much here. It seems to work fine actually but I
// want to understand it. Is sendMessage fine here ? How can I make sure
// creating 1 to 1 chats only so that not every connected user can get all the
// messages. Instead of only the chat partners of a chat

class SocketApi {
  late Socket socket;
  Auth auth = Auth.instance;

  ChatBloc chatBloc = ChatBloc(DatabaseApi.db);

  static final SocketApi _socketApi = SocketApi._internal();

  factory SocketApi(

      // you can pass here all data that you need to access. For example:
      // User user <-- might be helpful to send some user data...
      ) {
   // _socketApi.chatBloc = chatBloc;
   // print('user in socket api ${user}'); // <--- How to retrieve the user here? what am I missing here?
    return _socketApi;
  }

  // An internal private constructor to access it for only once for static
  // instance of class.

  // Whatever is encapsulated here is called only at the instance creation. and
  // since this is a singleton, this is called only once!
  SocketApi._internal() {
    
    try {
      socket = io(Platform.isAndroid ? 'ws://10.0.2.2:3000' : 'http://127.0.0.1:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      //? Connected
      // As soon as the current user is connected we get all infos and send
      // them to server. Here we are mostly interested in the socketId. We can
      // also send user.id or any information related to the user and which can
      // help us double check that we are indeed targeting to right user!

      socket.on('connect', (_) async {
        final values =await DatabaseApi.db.getUserByName('User A');
       
        socket.emit('addUser', {
          "socketId": socket.id,
          "id": values.id, //<-- this is the current user's id (not socketId)
          "userName": values.userName, // <-- current user firsName
          // "isOnline": true,
        });
        print('${socket.id} ${values.id} ${values.userName}');
        final updateUser = User(id: values.id, socketId: socket.id!, userName: values.userName);
    
        chatBloc.dbApi.updateSocketId(updateUser);
        chatBloc.add(LoadChatPartnersEvent());
         print('auth.currentUser after socket ${auth.currentUser}');
      
      });

      //? Reconnected
      /// Just in case user gets disconnected from server we reconnect ans send
      /// the same payload
      // socket.on('reconnect', (_) {
      //   socket.emit('addUser', {
      //     "socketId": socket.id,
      //     "id": user.currentUser.id,
      //     "userName": user.currentUser.userName,
      //     // "isOnline": true,
      //   });
      //   final updateUser = User(id: user.currentUser.id, socketId: socket.id!, userName: user.currentUser.userName);
      //   chatBloc.dbApi.updateSocketId(updateUser);
      //   chatBloc.add(LoadChatPartnersEvent());
      // });

      //! Error
      socket.on("error", (data) {
        /// You could call the onError from the chat bloc here (if any)
      });

      //? Disconnected
      socket.on('disconnect', (_) {
        // Do some cleanup if needed
      });

      // You could crate a dedicated slot to get list of all users...
      // this is a mock so you might need to implement your own
      // Basically this will trigger an event on the chatBloc to display the
      // list all users (connected and offline or only connected)
      socket.on("usersList", (data) {
        // List<ChatUser> connectedUsers =
        //     List<ChatUser>.from(data.map((u) => chatUserFromMap(u)));
        // chatBloc.add(ChatUpdateConnectedUsers(connectedUsers));
      });
    } catch (e) {
      /// You could call the onError from the chat bloc here (if any)
      rethrow;
    }
  }

   connect() {
    socket.connect();
    return true;
  }

  void disconnect() {
    socket.disconnect();
  }

  ///
  /// This is the perfect place for sending messages from the socket
  /// however you should call the [emitWithAck] to trigger the ui to update
  /// after the message has, indeed, completed successfully...
  sendMessage(String fromUserId, String toUserId, String message) {
    final Message sendMessage = Message(fromUserId: fromUserId, toUserId: toUserId, message: message);
    final Map<String, dynamic> map = sendMessage.toMap();

    print(map);

    socket.emit(
      'message',
      map
      //  {
      //   // here you can do what ever you ant with the data you get back from the
      //   // server. Here we are just sending a confirmation to the UI to show the
      //   // sent message... This is a pessimistic approach. you can instead go with
      //   // the optimistic approach and display the sent message in the UI without
      //   // confirmation then delete it if the message was not sent for whatever
      //   // raison

      //   // chatBloc.add(
      //   // ChatMessageSent(
      //   //   fromUserId: fromUserId,
      //   //   toUserId: toUserId,
      //   //   content: message,
      //   // ),
      //   // );
      //   print('object')
      //   //print('object $data');

      //   //chatBloc.add(ConversationAddMessageToConversationEvent(message: Message(fromUserId: data)));
        
      //   //print('inside emitWithAck ${sendMessage}');
      // },
    );

    chatBloc.add(ConversationAddMessageToConversationEvent(message: sendMessage));
  }
}
