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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
        child: Text('Start as hardcoded User', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        onPressed: () {
        Navigator
    .of(context)
    .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Chat()));
      },),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextButton(
              onPressed: (() async {
                 final res = await databaseApi.getUsers(); 
                 setState(() {
                   textOutput = res;
                 });
                 
              }),
              child: Text('Get Users'),),
              TextButton(
              onPressed: (() async {
                ChatUser mockData = ChatUser(id: 1, socketId: '453643543', userName: 'User A');
                
                 final res = await databaseApi.insertUser(mockData); 
                 setState(() {
                   textOutput = 'User created';
                 });
                 
              }),
              child: Text('Create random User'),),

              TextButton(
              onPressed: (() async {
             
                final user = ChatUser(id: 1, socketId: '1', userName: 'Marcel');
                 final res = await databaseApi.updateSocketId(user); 
                 setState(() {
                   textOutput = 'Updated socket Id of user';
                 });
                 
              }),
              child: Text('Update socket id'),),

              Text(textOutput != null ?  textOutput.toString() : '')
          ],
        ),
      ),
    );
  }
}
