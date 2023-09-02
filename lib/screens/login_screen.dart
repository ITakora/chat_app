import 'package:chat/widgets/form_widgets.dart';
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
      body: Container(
        margin: const EdgeInsets.only(bottom: 100),
        child: Center(
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
                    const FormWidget(),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Login')),
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
