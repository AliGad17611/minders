import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/common/custom_elevatedButton.dart';
import 'package:minders/features/common/custom_text_form_field.dart';
import 'package:minders/features/registration/cubit/authentication_cubit.dart';
import 'package:minders/features/registration/onboarding/onboarding.dart';

import 'auth_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationCubit(),
      child: Builder(
        builder: (_) {
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              bool isLoading = false;
              if (state is AuthenticationLoading) {
                isLoading = true;
              }
              if (state is AuthenticationSuccess) {
                isLoading = false;
                _successFlow(context);
              }
              if (state is AuthenticationFailure) {
                isLoading = false;
                _failureFlow(context, state);
              }

              return _content(context, isLoading: isLoading);
            },
          );
        },
      ),
    );
  }

  void _failureFlow(BuildContext context, AuthenticationFailure state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.error),
        backgroundColor: AppColors.errorTextColors,
      ),
    );
  }

  void _successFlow(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Onboarding()),
      (route) => false,
    );
  }

  AuthFormScreen _content(BuildContext context, {bool isLoading = false}) {
    return AuthFormScreen(
      title: 'Create your account ',
      middleText: 'OR SIGN UP WITH EMAIL',
      bottomText: ['ALREADY have an account? ', 'Sign in'],
      isLoading: isLoading,
      form: SignupForm(
        onSubmit: context.read<AuthenticationCubit>().signup,
        isLoading: isLoading,
      ),
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

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, this.onSubmit, this.isLoading = false});
  final Function(String userName, String email, String password)? onSubmit;
  final bool isLoading;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  bool check = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        children: [
          CustomTextFormField(
            controller: _userNameController,
            label: 'UserName',
            enabled: true,
            isRequired: true,
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                text: TextSpan(
                    text: "i have read the ",
                    style: AppTextStyles.text14w700Tertiary,
                    children: [
                      TextSpan(
                        text: "Privace Policy",
                        style: AppTextStyles.text14w700Tertiary
                            .copyWith(color: AppColors.purpleAccent),
                      ),
                    ]),
              ),
              Checkbox(
                value: check,
                side: BorderSide(color: AppColors.border),
                onChanged: (value) {
                  check = value ?? false;
                  setState(() {});
                },
              )
            ],
          ),
          CustomElevatedButton(
            backgroundColor: AppColors.purpleAccent,
            foregroundColor: AppColors.whiteTextColors,
            title: 'GET STARTED',
            onPressed: _signUp,
          ),
        ],
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final String userName = _userNameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      widget.onSubmit?.call(userName, email, password);
    }
  }
}
