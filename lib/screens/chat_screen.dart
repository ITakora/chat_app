import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Center(
          child: TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('Log Out'))),
    );
  }
}
