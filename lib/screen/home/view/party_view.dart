import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/customs/custom_style.dart';
import 'package:partyhaan/customs/custom_value.dart';

import '../../../models/party_model.dart';
import '../../partyDetail/view/party_detail_screen.dart';
import '../cubic/home_cubit.dart';

class PartyView extends StatelessWidget {
  const PartyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      List<Party> partyList = state.partyList;
      return ListView.builder(
          padding: const EdgeInsets.all(IValue.mainPadding),
          itemCount: partyList.length,
          itemBuilder: (BuildContext context, int index) {
            Party party = state.partyList[index];
            return GestureDetector(
              onTap: () => _onClickPartyDetail(party, context),
              child: _PartyTile(
                party: party,
              ),
            );
          });
    });
  }

  void _onClickPartyDetail(Party party, BuildContext context) {
    Navigator.of(context).push<void>(
      PartyDetailScreen.route(party),
    );
  }
}

class _PartyTile extends StatelessWidget {
  final Party party;

  const _PartyTile({Key? key, required this.party}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IValue.partyTileImageRadius),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(IValue.partyTileImageRadius),
            ),
            child: Image.network(
              party.image,
              height: IValue.partyTileImageHeight,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(IValue.mainPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(party.name, style: ITextStyles.partyTileName),
                    Text(
                      party.product,
                      style: ITextStyles.partyTileProduct,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(party.price.toString(),
                        style: ITextStyles.partyTilePrice),
                    Text("${party.count}/${party.maxCount}",
                        style: ITextStyles.partyTileCount),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
