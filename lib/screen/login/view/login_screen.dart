import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/customs/custom_value.dart';
import 'package:partyhaan/repositories/auth_repository.dart';
import 'package:partyhaan/screen/login/cubic/login_cubit.dart';

import '../../../customs/custom_color.dart';
import '../../../customs/custom_image.dart';
import '../../../customs/custom_style.dart';
import '../../../customs/custom_text.dart';
import '../../signup/view/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const LoginForm()),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          //do something when error
        }
      },
      child: Container(
        color: IColors.bgBlue,
        padding: const EdgeInsets.only(
            right: IValue.mainPaddingRL, left: IValue.mainPaddingRL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _LogoImage(),
            SizedBox(height: IValue.loginLogoPaddingB),
            _EmailInput(),
            SizedBox(height: IValue.mainBoxHeight),
            _PasswordInput(),
            SizedBox(height: IValue.mainBoxHeight),
            _LoginButton(),
            SizedBox(height: IValue.mainBoxHeight),
            _SignupButton()
          ],
        ),
      ),
    );
  }
}

class _LogoImage extends StatelessWidget {
  const _LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(IImage.loginLogo,
        width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth);
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          obscureText: true,
          decoration: const InputDecoration(labelText: IText.loginPasswordHint),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
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
                          context.read<LoginCubit>().loginWithCredentials(),
                      child: Text(IText.loginLoginBtn,
                          style: ITextStyles.partyBtn),
                    )));
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
            onTap: () => Navigator.of(context).push<void>(
                  SignupScreen.route(),
                ),
            child: const Padding(
              padding: EdgeInsets.all(IValue.mainPadding),
              child: Text(IText.loginRegisterBtn),
            )));
  }
}
