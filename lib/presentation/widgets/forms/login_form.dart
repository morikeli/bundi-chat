import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/helpers/form_validation.dart';
import '../../../core/theme/color.dart';
import '../../../core/utils/app_loading_indicators.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../common/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailInputField(emailController: emailController),
          const SizedBox(height: 20),
          PasswordInputField(passwordController: passwordController),
          const SizedBox(height: 12.0),
          // "Remember Me" checkbox and "Forgot password" text
          ForgotPasswordLink(),
          const SizedBox(height: 20.0),
          LoginBtn(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  const EmailInputField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      label: "Email",
      icon: LineIcons.envelope,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      label: "Password",
      icon: LineIcons.lock,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, passwordController.text);
      },
    );
  }
}

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgot-password'),
          child: Text(
            'Forgot password?',
            style: TextStyle(color: kLinkColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final form = formKey.currentState;

              if (form != null && form.validate()) {
                final username = emailController.text.trim();
                final password = passwordController.text.trim();

                context.read<AuthBloc>().add(
                  LoginRequested(email: username, password: password),
                );
              }
            },
            child: isLoading
                ? Center(child: AppLoadingIndicators.loadingIndicatorMedium())
                : const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}
