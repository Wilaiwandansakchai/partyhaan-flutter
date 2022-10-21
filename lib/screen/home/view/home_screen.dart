import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/repositories/party_repository.dart';
import 'package:partyhaan/screen/home/cubic/home_cubit.dart';
import 'package:partyhaan/screen/home/view/party_view.dart';

import '../../../blocs/app_bloc/app_bloc.dart';
import '../../../blocs/party_bloc/party_bloc.dart';
import '../../../customs/custom_color.dart';
import '../../../customs/custom_style.dart';
import '../../../customs/custom_text.dart';
import '../../createParty/view/create_party_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomeScreen());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    PartyRepository partyRepository = PartyRepository();
    return RepositoryProvider.value(
        value: partyRepository,
        child: BlocProvider(
          create: (_) => PartyBloc(partyRepository: partyRepository),
          child: const HomeView(),
        ));
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: IColors.nav,
        title: Text(
          IText.navParty,
          style: ITextStyles.navTitle,
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<AppBloc>().add(AppLogoutRequested()),
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _onClickOpenCreatePartyScreen(context),
        child: const Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ), // Thi
      body: BlocProvider(
          create: (_) {
            final cubit = HomeCubit(context.read<PartyRepository>());
            cubit.fetchPartyList();
            return cubit;
          },
          child: SafeArea(
              child: Container(
            color: IColors.bgOrange,
            child: const Expanded(child: PartyView()),
          ))),
    );
  }

  _onClickOpenCreatePartyScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<CreatePartyScreen>(
        builder: (_) => RepositoryProvider.value(
          value: context.read<PartyRepository>(),
          child: const CreatePartyScreen(),
        )));
  }
}
