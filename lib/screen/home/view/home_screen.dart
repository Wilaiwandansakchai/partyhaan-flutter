import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/repositories/party_repository.dart';
import 'package:partyhaan/screen/home/cubic/home_cubit.dart';

import '../../../blocs/app_bloc/app_bloc.dart';
import '../../../blocs/party_bloc/party_bloc.dart';
import '../../../models/party_model.dart';

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
          create: (_) => PartyBloc(partyRepository: partyRepository)
            ..add(FetchPartyList()),
          child: const HomeView(),
        ));
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) {
            final cubit = HomeCubit(context.read<PartyRepository>());
            cubit.fetchPartyList();
            return cubit;
          },
          child: const Test()),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequested()),
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    context.read<HomeCubit>().createParty();
                  },
                  child: Text("add")),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.partyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Party party = state.partyList[index];
                          return Container(
                            height: 50,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(party.image)
                                ),
                                Text('Entry ${party.name}'),
                              ],
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class _PartyListview extends StatelessWidget {
  const _PartyListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartyBloc, PartyState>(
      builder: (context, state) {
        state.partyList;
        return Text("party : ${state.partyList}");
      },
    );
  }
}
