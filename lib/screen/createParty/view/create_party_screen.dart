import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/party_repository.dart';
import '../cubic/create_party_cubit.dart';

class CreatePartyScreen extends StatelessWidget {
  const CreatePartyScreen({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: CreatePartyScreen());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreatePartyScreen());
  }

  @override
  Widget build(BuildContext context) {
    PartyRepository partyRepository = PartyRepository();

    return Scaffold(
      body: BlocProvider(
          create: (_) => CreatePartyCubit(partyRepository),
          child: const PartyForm()),
    );
  }
}

class PartyForm extends StatelessWidget {
  const PartyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePartyCubit, CreatePartyState>(
      listener: (context, state) {
        if (state is CreateSuccessState) {
          Navigator.of(context).pop();
        } else if (state is CreateFailState) {
          print("CreateFailed");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [_CreateButton()],
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<CreatePartyCubit>().createParty();
        },
        child: Text("add"));
  }
}
