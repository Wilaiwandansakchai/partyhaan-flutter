import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:partyhaan/models/party_model.dart';

import '../../../repositories/party_repository.dart';

part 'party_detail_state.dart';

enum userStatus { none, join, host }

class PartyDetailCubit extends Cubit<PartyDetailState> {
  final PartyRepository _partyRepository;
  final Party _party;

  PartyDetailCubit(this._partyRepository, {required Party party})
      : _party = party,
        super(PartyDetailInitial());

  Future<void> joinParty() async {
    try {
      await _partyRepository.joinParty(party: _party);
    } catch (_) {}
  }
}
