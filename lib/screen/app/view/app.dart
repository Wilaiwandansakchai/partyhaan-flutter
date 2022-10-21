import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/routes.dart';
import '../../../blocs/app_bloc/app_bloc.dart';
import '../../../customs/custom_text.dart';
import '../../../repositories/auth_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    return RepositoryProvider(
        create: (context) => authRepository,
        child: BlocProvider(
          create: (_) => AppBloc(authRepository: authRepository),
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: IText.nameApp,
        debugShowCheckedModeBanner: false,
        home: FlowBuilder<AppStatus>(
            state: context.select((AppBloc bloc) => bloc.state.status),
            onGeneratePages: onGenerateAppViewPages));
  }
}
