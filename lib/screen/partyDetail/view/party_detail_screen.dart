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

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    PartyRepository partyRepository = PartyRepository();
    return BlocProvider(
        create: (_) => PartyDetailCubit(partyRepository, party: _party, user: user),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: IColors.nav,
            title: Text(
              IText.navParty,
              style: ITextStyles.navTitle,
            ),
          ),
          bottomNavigationBar: const _BottomNav(),
          body: SafeArea(
            child: Container(
                color: IColors.bgEgg, child: _PartyDetailView(party: _party)),
          ),
        ));
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
                onPressed: () => context.read<PartyDetailCubit>().joinParty(),
                child: Text(IText.partyJoinBtn, style: ITextStyles.partyBtn),
              ))),
    );
  }
}

class _PartyDetailView extends StatelessWidget {
  final Party _party;

  const _PartyDetailView({Key? key, required Party party})
      : _party = party,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_imageView(context), _titleView()],
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
              Text("ราคาเต็ม ${_party.price.toString()}", style: ITextStyles.partyTilePrice),
              Text("ราคาเมื่อเข้าร่วม ${_party.price/_party.count}", style: ITextStyles.partyTilePrice),
              Text("${_party.count}/${_party.maxCount}",
                  style: ITextStyles.partyTileCount),
            ],
          ),
        ],
      ),
    );
  }
}
