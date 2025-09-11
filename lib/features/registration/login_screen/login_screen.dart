import 'package:flutter/material.dart';

import 'auth_form.dart';
import 'login_form.dart';
import 'sign_up_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFormScreen(
      title: 'Create your account ',
      middleText: 'OR SIGN UP WITH EMAIL',
      bottomText: ['ALREADY have an account? ', 'Sign in'],
      form: SignupForm(),
      onChange: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }
}
