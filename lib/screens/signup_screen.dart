import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void _submitButton() async {
    final valid = _form.currentState!.validate();
    if (!valid) {
      return;
    }
    _form.currentState!.save();
    try {
      final newUser = await firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
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
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: 180,
              child: Image.asset('assets/images/chat.png'),
            ),
            const SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
