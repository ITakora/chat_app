import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  _signOutGoogle() async {
    final GoogleSignInAccount? googleSignOut =
        await GoogleSignIn().disconnect();
    return googleSignOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Center(
          child: TextButton(
              onPressed: () {
                _signOutGoogle();
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Log Out'))),
    );
  }
}
