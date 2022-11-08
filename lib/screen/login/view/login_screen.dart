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
          child: LoginForm()),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text(IText.errorText)),
            );
        } else if (state.status == LoginStatus.success) {
          //LOGIN success
        }
      },
      child: Container(
        color: IColors.bgBlue,
        padding: const EdgeInsets.only(
            right: IValue.mainPaddingRL, left: IValue.mainPaddingRL),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _LogoImage(),
              const SizedBox(height: IValue.loginLogoPaddingB),
              const _EmailInput(),
              const SizedBox(height: IValue.mainBoxHeight),
              const _PasswordInput(),
              const SizedBox(height: IValue.mainBoxHeight),
              _LoginButton(form: _formKey),
              const SizedBox(height: IValue.mainBoxHeight),
              const _SignupButton()
            ],
          ),
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
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return IText.txtTextHint;
            }
            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return IText.txtPasswordHint;
            }
            return null;
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
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return IText.txtTextHint;
            }
            if (value.length < 8) {
              return IText.txtPasswordHint;
            }
            return null;
          },
          obscureText: true,
          decoration: const InputDecoration(labelText: IText.loginPasswordHint),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final GlobalKey<FormState> _form;

  const _LoginButton({Key? key, required GlobalKey<FormState> form})
      : _form = form,
        super(key: key);

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
                      onPressed: () => _onClickLogin(context),
                      child: Text(IText.loginLoginBtn,
                          style: ITextStyles.partyBtn),
                    )));
      },
    );
  }

  _onClickLogin(BuildContext context) {
    if (_form.currentState!.validate()) {
      context.read<LoginCubit>().loginWithCredentials();
    }
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
            onTap: () => _onClickOpenSignupScreen(context),
            child: const Padding(
              padding: EdgeInsets.all(IValue.mainPadding),
              child: Text(IText.loginRegisterBtn),
            )));
  }

  _onClickOpenSignupScreen(BuildContext context) {
    Navigator.of(context).push<void>(
      SignupScreen.route(),
    );
  }
}
