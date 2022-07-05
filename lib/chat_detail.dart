import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
  title: Text("Chatpartner Name"),
  centerTitle: true,
),
      body: Center(
        child: Text('Silence here at the moment'),
      ),
    );
  }
}
