# chat.dart
- We are displaying the socket id here, unfortunately the UI is showing the old socket id, the new socket id has to be refreshed for the UI in some way. Could you check this please?
- From line [27] is there a better approach? I first tried to wrap it in initstate but then I always got null on my user object

# main.dart
line [18]. Is it correct that I always have to pass an instance now? Could you explain me this pattern a little bit more? I also needed to pass it on line [18] in [socket_api.dart]

# General
- what is the difference between a constructor and a factory constructor actually?
- Could you please check the complete code? And if you find better approaches please rewrite the code and comment it so I can improve my code understanding and learn more from you.
