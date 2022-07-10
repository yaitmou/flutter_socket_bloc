# socket_api.dart
- I managed to update the [socketId] and display the new one in the ui by adding [chatBloc.add(LoadChatPartnersEvent());] on line [59] and [74]. is there a better appraoch than calling this event if we are focusing on performance? Also why is it actually working without using the [Equatable] package? Can you explain me a use case where the package is needed?
- I have to call in line [57] and [58]  [chatBloc.dbApi.updateSocketId(updateUser);] then [chatBloc.add(LoadChatPartnersEvent();] is this correct or do i have to call such functions like [chatBloc.dbApi.updateSocketId(updateUser);] in my [chat_bloc.dart] ?
- 10. July 22: since my newest code update I'm not able to get the socketId updated anymore and I'm not understanding why actually. I need your assistance on this(!!)
# main.dart
line [18]. Is it correct that I always have to pass an instance now? Could you explain me this pattern a little bit more? I also needed to pass it on line [18] in [socket_api.dart]

# General
- what is the difference between a constructor and a factory constructor actually?
- Could you please check the complete code? And if you find better approaches please rewrite the code and comment it so I can improve my code understanding and learn more from you.
