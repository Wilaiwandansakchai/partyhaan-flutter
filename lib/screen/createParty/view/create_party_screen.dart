import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../customs/custom_color.dart';
import '../../../customs/custom_style.dart';
import '../../../customs/custom_text.dart';
import '../../../customs/custom_value.dart';
import '../../../repositories/party_repository.dart';
import '../cubic/create_party_cubit.dart';

class CreatePartyScreen extends StatelessWidget {
  const CreatePartyScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreatePartyScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePartyCubit(context.read<PartyRepository>()),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: IColors.nav,
            title: Text(
              IText.navCreateParty,
              style: ITextStyles.navTitle,
            ),
          ),
          bottomNavigationBar: const _BottomNav(),
          body: SafeArea(
            child: Container(
                color: IColors.bgEgg,
                padding: const EdgeInsets.only(
                    right: IValue.mainPaddingRL, left: IValue.mainPaddingRL),
                child: const PartyForm()),
          )),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: IColors.bgEgg,
      child: Padding(
          padding: const EdgeInsets.all(IValue.mainPadding),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: IColors.btnYellow,
                  borderRadius: BorderRadius.circular(IValue.btnRadius)),
              child: TextButton(
                onPressed: () => context.read<CreatePartyCubit>().createParty(),
                child: Text(IText.createPartyBtn, style: ITextStyles.partyBtn),
              ))),
    );
  }
}

class PartyForm extends StatelessWidget {
  const PartyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePartyCubit, CreatePartyState>(
        listener: (context, state) {
          if (state.status == CreatePartyStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text(IText.errorText)),
              );
          } else if (state.status == CreatePartyStatus.success) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _NameInput(),
              SizedBox(height: IValue.mainBoxHeight),
              _ProductInput(),
              SizedBox(height: IValue.mainBoxHeight),
              _MaxCountInput(),
              SizedBox(height: IValue.mainBoxHeight),
              _PriceInput(),
              SizedBox(height: IValue.mainBoxHeight),
              _ImageInput(),
              SizedBox(height: IValue.mainBoxHeight),
            ],
          ),
        ));
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyCubit, CreatePartyState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CreatePartyCubit>().nameChanged(value);
          },
          decoration: const InputDecoration(labelText: IText.createPartyName),
        );
      },
    );
  }
}

class _ProductInput extends StatelessWidget {
  const _ProductInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyCubit, CreatePartyState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CreatePartyCubit>().productChanged(value);
          },
          decoration:
              const InputDecoration(labelText: IText.createPartyProduct),
        );
      },
    );
  }
}

class _MaxCountInput extends StatelessWidget {
  const _MaxCountInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyCubit, CreatePartyState>(
      buildWhen: (previous, current) => previous.maxCount != current.maxCount,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value != "") {
              var number = int.parse(value);
              context.read<CreatePartyCubit>().maxCountChanged(number);
            }
          },
          decoration:
              const InputDecoration(labelText: IText.createPartyMaxCount),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  const _PriceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyCubit, CreatePartyState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value != "") {
              var number = int.parse(value);
              context.read<CreatePartyCubit>().priceChanged(number);
            }
          },
          decoration: const InputDecoration(labelText: IText.createPartyPrice),
        );
      },
    );
  }
}

class _ImageInput extends StatelessWidget {
  const _ImageInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePartyCubit, CreatePartyState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CreatePartyCubit>().imageChanged(value);
          },
          decoration: const InputDecoration(labelText: IText.createPartyImage),
        );
      },
    );
  }
}
