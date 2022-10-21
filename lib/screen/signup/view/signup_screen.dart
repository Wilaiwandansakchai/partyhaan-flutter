import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/screen/signup/cubic/signup_cubit.dart';

import '../../../customs/custom_color.dart';
import '../../../customs/custom_style.dart';
import '../../../customs/custom_text.dart';
import '../../../customs/custom_value.dart';
import '../../../repositories/auth_repository.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: SignupScreen());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: IColors.nav,
        title: Text(
          IText.navSignup,
          style: ITextStyles.navTitle,
        ),
      ),
      body: BlocProvider(
          create: (_) => SignupCubit(context.read<AuthRepository>()),
          child: const SignupForm()),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text(IText.errorText)),
            );
        } else if (state.status == SignupStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: IColors.bgEgg,
        padding: const EdgeInsets.only(
            right: IValue.mainPaddingRL, left: IValue.mainPaddingRL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _EmailInput(),
            SizedBox(height: 5),
            _PasswordInput(),
            SizedBox(height: 5),
            _SignupButton()
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: IText.loginEmailHint),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (email) {
            context.read<SignupCubit>().passwordChanged(email);
          },
          decoration: const InputDecoration(labelText: IText.loginPasswordHint),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(IValue.mainPadding),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: IColors.btnYellow,
                        borderRadius: BorderRadius.circular(IValue.btnRadius)),
                    child: TextButton(
                      onPressed: () =>
                          context.read<SignupCubit>().signupFormSubmitted(),
                      child: Text(IText.signupBtn, style: ITextStyles.partyBtn),
                    )));
      },
    );
  }
}
