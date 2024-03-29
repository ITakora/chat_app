import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';

class SignInGoogle extends StatelessWidget {
  const SignInGoogle({super.key});

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow

    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (authResult.additionalUserInfo!.isNewUser) {
      if (user != null) {
        return authResult;
      }
    } else {}
    // Once signed in, return the UserCredential
    return authResult;
  }

  @override
  Widget build(BuildContext context) {
    return SignInButton.mini(
      elevation: 2,
      customImage: CustomImage('assets/images/google.png'),
      buttonSize: ButtonSize.large,
      buttonType: ButtonType.google,
      onPressed: () {
        _signInWithGoogle();
      },
    );
    //SignInButton(Buttons.Google, onPressed: () {
    //   _signInWithGoogle();
    // });
  }
}
