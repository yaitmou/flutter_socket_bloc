# socket_api.dart
Here im stuck on line [29]. Im not able to retrieve the user data. For demo purposes im providing a hardcoded id [1]
on line [33] in [chat.dart]. On line [34] before it goes to the [socket_api] class i have the data which is not null

# Open question 1 / need advice
I  saw repos which used the bloc file in a different way. They emit state + 1 instead of the state name. Are these approaches similar or is there any difference?

# Open questions 2 / need advice
I’m unsure if I did any mistakes on the chat_bloc chat_state and the chat_event. Could you maybe give me more explanation on this files here?
From my understanding the states is the different states the application can have. In this case initial state, state when messages aren’t there but loading, error state and so on. Events is every piece of function which is getting implemented and the bloc is the place reacting to the events and emiting states. Is that right? Do I have mistakes on these 3 files?