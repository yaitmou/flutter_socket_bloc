import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_socket/chat.dart';
import 'package:flutter_bloc_socket/apis/database_api.dart';
import 'package:flutter_bloc_socket/models/chat_user.dart';
import 'package:flutter_bloc_socket/apis/socket_api.dart';

import 'bloc/chat/chat_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Is this the correct approach here to do it like this?
  late SocketApi socketApi;
  DatabaseApi databaseApi = DatabaseApi.db;

  var textOutput;

  @override
  void initState() {
    super.initState();
    databaseApi.initDB();

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
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              TextButton(
                onPressed: (() async {
                  final res = await databaseApi.getUsers();
                  setState(() {
                    textOutput = res;
                  });
                }),
                child: Text('Get Users'),
              ),
              TextButton(
                onPressed: (() async {
                  User mockData = User(
                      id: 3, socketId: '32343242', userName: 'User C');

                  final res = await databaseApi.insertUser(mockData);
                  setState(() {
                    textOutput = 'User created';
                  });
                }),
                child: Text('Create random User'),
              ),
              TextButton(
                onPressed: (() async {
                  final user =
                      User(id: 1, socketId: '1', userName: 'Marcel');
                  final res = await databaseApi.updateSocketId(user);
                  setState(() {
                    textOutput = 'Updated socket Id of user';
                  });
                }),
                child: Text('Update socket id'),
              ),
              Text(textOutput != null ? textOutput.toString() : ''),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Username',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  TextButton(
                    
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                           MaterialPageRoute(
                              builder: (BuildContext context) =>  Chat(myController.text)));
                    },
                  ),
                ])),
          ),
        ),
      ],
    ));
  }
}
