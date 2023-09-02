import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Email Addres',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
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
    );
  }
}
