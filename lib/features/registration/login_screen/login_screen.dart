import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/features/common/custom_elevatedButton.dart';
import 'package:minders/features/common/custom_text_form_field.dart';
import 'package:minders/features/registration/cubit/authentication_cubit.dart';
import 'package:minders/features/registration/onboarding/onboarding.dart';

import 'auth_form.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => AuthenticationCubit(),
      child: Builder(
        builder: (context) {
          bool isLoading = false;
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (ctxt, state) {
              if (state is AuthenticationLoading) {
                isLoading = true;
              }
              if (state is AuthenticationSuccess) {
                isLoading = false;
                _successflow(ctxt);
              }
              if (state is AuthenticationFailure) {
                isLoading = false;
                _failureFLow(ctxt, state.error);
              }
            },
            child: _loginContent(context, isLoading: isLoading),
          );
        },
      ),
    );
  }

  void _failureFLow(BuildContext ctxt, String error) {
    ScaffoldMessenger.of(ctxt).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: TextStyle(color: AppColors.whiteTextColors),
        ),
        backgroundColor: AppColors.errorTextColors,
      ),
    );
  }

  void _successflow(BuildContext ctxt) {
    Navigator.pushAndRemoveUntil(
      ctxt,
      MaterialPageRoute(builder: (ctxt) => Onboarding()),
      (route) => false,
    );
  }

  AuthFormScreen _loginContent(BuildContext ctxt, {bool isLoading = false}) {
    return AuthFormScreen(
      title: 'Welcome Back!',
      middleText: 'OR LOG IN WITH EMAIL',
      bottomText: ['Don\'t have an account? ', 'Sign up'],
      isLoading: isLoading,
      form: LoginForm(
        onSubmit: ctxt.read<AuthenticationCubit>().login,
      ),
      onChange: () {
        Navigator.pushReplacement(
          ctxt,
          MaterialPageRoute(builder: (ctxt) => SignupScreen()),
        );
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.onSubmit});

  final Function(String email, String password)? onSubmit;

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
      final String email = _emailController.text;
      final String password = _passwordController.text;

      widget.onSubmit?.call(email, password);
    }
  }
}
