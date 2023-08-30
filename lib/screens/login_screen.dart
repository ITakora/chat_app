import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        heightFactor: double.infinity,
        child: SingleChildScrollView(
            child: Card(
          elevation: 0,
          margin: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                width: 180,
                child: Image.asset('assets/images/chat.png'),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email Addres',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              )),
                            ),
                            autocorrect: false,
                            obscureText: true,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Login')),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
