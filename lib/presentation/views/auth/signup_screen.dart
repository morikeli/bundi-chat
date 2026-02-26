import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/errors.dart';
import '../../../core/utils/app_toast.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../widgets/common/footer.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/forms/signup_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Create Account',
        goBackToPreviousScreen: true,
      ),

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AccountCreated) {
            Navigator.pop(context);
            AppToast.showSuccess(context, title: kSignupSuccess);
          } else if (state is SignupFailed) {
            AppToast.showError(
              context,
              title: kSignupFailedError,
              message: state.errorMessage.toString(),
            );
          }
        },

        builder: (context, state) => SignupScreenBody(),
      ),

      // Footer
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      persistentFooterButtons: [
        Footer(
          primaryText: "Already have an account? ",
          redirectText: "Login",
          redirectTo: TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, LoginScreen.routeName),
        ),
      ],
    );
  }
}

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SignupScreenSubTitle(),
            SizedBox(height: 16.0),
            SignupForm(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class SignupScreenSubTitle extends StatelessWidget {
  const SignupScreenSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Another day to sell your soul (not literally) to another app',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16.0),
      textAlign: TextAlign.center,
    );
  }
}
