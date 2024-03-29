import 'dart:io';

import 'package:chat/widgets/google_signin.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  String? _errorMessage;
  late FocusNode myFocusNode;
  File? userImage;

  void _submitButton() async {
    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }
    _form.currentState!.save();

    try {
      final newUser = await firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);

      final storageImage = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${newUser.user!.uid}.jpg');

      await storageImage.putFile(userImage!);
      final imageUrl = await storageImage.getDownloadURL();
      print(imageUrl);

      EasyLoading.showSuccess('Your SignUp is Successfully');
    } on FirebaseAuthException catch (err) {
      if (err.message == null) {
        return;
      } else {
        setState(() {
          _errorMessage = err.message;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 180,
              child: Text(
                'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserImagePicker(
                    onPickImage: (pickedImage) {
                      userImage = pickedImage;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.go,
                          decoration: const InputDecoration(
                            hintText: 'Email Addres',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Please enter the email';
                            }

                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredEmail = newValue!;
                          },
                          onFieldSubmitted: (value) =>
                              myFocusNode.requestFocus(),
                          autofocus: true,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          focusNode: myFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            )),
                          ),
                          autocorrect: false,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredPassword = newValue!;
                          },
                          onFieldSubmitted: (value) => _submitButton(),
                        )
                      ],
                    ),
                  ),
                  Text(_errorMessage == null ? '' : _errorMessage!),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: _submitButton, child: const Text('Sign Up')),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const Center(
                  //   child: SignInGoogle(),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have Account ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Sign In'))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
