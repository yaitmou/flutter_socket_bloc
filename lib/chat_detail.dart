import 'package:flutter/material.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail(final this.userName, {Key? key}) : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(userName),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Silence here at the moment'),
      ),
    );
  }
}
