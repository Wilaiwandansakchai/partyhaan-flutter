import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/app/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequested()),
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: SafeArea(
            child: Align(
          alignment: const Alignment(0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    user.photo != null ? NetworkImage(user.photo!) : null,
                child: user.photo == null ? const Icon(Icons.person) : null,
              ),
              Text(user.id)
            ],
          ),
        )));
  }
}
