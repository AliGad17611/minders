import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/common/custom_elevatedButton.dart';
import 'package:minders/features/common/custom_text_form_field.dart';

import 'auth_form.dart';
import 'login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFormScreen(
      title: 'Welcome Back!',
      middleText: 'OR LOG IN WITH EMAIL',
      bottomText: ['Don\'t have an account? ', 'Sign up'],
      form: LoginForm(),
      onChange: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignupScreen(),
            ));
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          CustomTextFormField(
            controller: _emailController,
            label: 'Email',
            enabled: true,
            isRequired: true,
          ),
          CustomTextFormField(
            controller: _passwordController,
            label: 'Password',
            obscureText: true,
            isRequired: true,
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            backgroundColor: AppColors.purpleAccent,
            foregroundColor: AppColors.whiteTextColors,
            title: 'LOG IN',
            onPressed: _login,
          ),
        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
    }
  }
}
