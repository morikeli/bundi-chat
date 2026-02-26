import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/theme/color.dart';
import '../../../core/utils/app_toast.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/forms/login_form.dart';
import '../home/homescreen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is IsAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          } else if (state is AuthError) {
            AppToast.showError(
              context,
              title: 'Authentication error!',
              message: state.errorMessage.toString(),
            );
          }
        },
        builder: (context, state) => LoginScreenBody(),
      ),

      // Footer
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      persistentFooterButtons: [
        Footer(
          primaryText: "Don't have an account? ",
          redirectText: "Sign up",
          redirectTo: TapGestureRecognizer()
            ..onTap = () =>
                Navigator.pushNamed(context, SignupScreen.routeName),
        ),
      ],
    );
  }
}

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SizedBox(height: 40),
          LoginScreenIcon(),
          SizedBox(height: 24.0),
          LoginScreenTitle(),
          const SizedBox(height: 12.0),
          LoginScreenSubTitle(),
          const SizedBox(height: 40),
          // LoginForm widget
          LoginForm(),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}

class LoginScreenIcon extends StatelessWidget {
  const LoginScreenIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: kContainerLightColor,
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.all(16.0),
        child: Icon(LineIcons.commentsAlt, color: kIconDarkColor, size: 28.0),
      ),
    );
  }
}

class LoginScreenTitle extends StatelessWidget {
  const LoginScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class LoginScreenSubTitle extends StatelessWidget {
  const LoginScreenSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sign in to continue',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    );
  }
}
