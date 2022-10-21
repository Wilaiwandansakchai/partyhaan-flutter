import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/app_bloc/app_bloc.dart';
import '../../../customs/custom_color.dart';
import '../../../customs/custom_style.dart';
import '../../../customs/custom_text.dart';
import '../../../customs/custom_value.dart';
import '../../../models/party_model.dart';
import '../../../repositories/party_repository.dart';
import '../cubic/party_detail_cubit.dart';

class PartyDetailScreen extends StatelessWidget {
  final Party _party;

  const PartyDetailScreen({Key? key, required Party party})
      : _party = party,
        super(key: key);

  static Route<void> route(Party party) {
    return MaterialPageRoute<void>(
        builder: (_) => PartyDetailScreen(party: party));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
        create: (_) => PartyDetailCubit(context.read<PartyRepository>(),
            party: _party, user: user),
        child: BlocListener<PartyDetailCubit, PartyDetailState>(
            listener: (context, state) {
              if (state is PartyDetailSuccessState) {
                Navigator.of(context).pop();
              } else if (state is PartyDetailFailState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text(IText.errorText)),
                  );
              }
            },
            child: _PartyDetailView(party: _party)));
  }
}

class _BottomNav extends StatelessWidget {
  final Party _party;

  const _BottomNav({Key? key, required Party party})
      : _party = party,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: IColors.bgEgg,
        child: (_party.isHost!) ? _hostBtn(context) : _joinBtn(context));
  }

  _joinBtn(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(IValue.mainPadding),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color:
                    (_party.isMember!) ? IColors.btnDisable : IColors.btnYellow,
                borderRadius: BorderRadius.circular(IValue.btnRadius)),
            child: TextButton(
              onPressed: (_party.isMember!)
                  ? null
                  : () => context.read<PartyDetailCubit>().joinParty(),
              child: Text(IText.partyJoinBtn, style: ITextStyles.partyBtn),
            )));
  }

  _hostBtn(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(IValue.mainPadding),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: IColors.btnGreen,
                borderRadius: BorderRadius.circular(IValue.btnRadius)),
            child: TextButton(
              onPressed: () => context.read<PartyDetailCubit>().closeParty(),
              child: Text(IText.partyCloseBtn, style: ITextStyles.partyBtn),
            )));
  }
}

class _PartyDetailView extends StatelessWidget {
  final Party _party;

  const _PartyDetailView({Key? key, required Party party})
      : _party = party,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: IColors.nav,
        title: Text(
          IText.navParty,
          style: ITextStyles.navTitle,
        ),
      ),
      bottomNavigationBar: _BottomNav(party: _party),
      body: SafeArea(
        child: Container(
            color: IColors.bgEgg,
            child: Column(children: [_imageView(context), _titleView()])),
      ),
    );
  }

  _imageView(BuildContext context) {
    return Image.network(
      _party.image,
      height: IValue.partyImageHeight,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
    );
  }

  _titleView() {
    return Padding(
      padding: const EdgeInsets.all(IValue.mainPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_party.name, style: ITextStyles.partyTileName),
              Text(
                _party.product,
                style: ITextStyles.partyTileProduct,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${IText.partyDetailFullCost} ${_party.price.toString()} ${IText.partyDetailCostUnit}",
                  style: ITextStyles.partyDetailFullCost),
              Text("${IText.partyDetailCost} ${_party.dividePrice} ${IText.partyDetailCostUnit}",
                  style: ITextStyles.partyDetailCost),
              Text("${IText.partyDetailMember} ${_party.countMember}/${_party.maxCount}",
                  style: ITextStyles.partyTileCount),
            ],
          ),
        ],
      ),
    );
  }
}
