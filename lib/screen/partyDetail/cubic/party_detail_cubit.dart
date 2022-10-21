import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:partyhaan/models/party_model.dart';

import '../../../models/user_model.dart';
import '../../../repositories/party_repository.dart';

part 'party_detail_state.dart';

class PartyDetailCubit extends Cubit<PartyDetailState> {
  final PartyRepository _partyRepository;
  final Party _party;
  final User _user;

  PartyDetailCubit(this._partyRepository,
      {required Party party, required User user})
      : _party = party,
        _user = user,
        super(PartyDetailState());

  Future<void> joinParty() async {
    try {
      final myId = _user.id;
      final List<String> userMemberList = _party.member;
      final Set<String> memberSet = userMemberList.map((e) => e).toSet();
      final alreadySaved = memberSet.contains(myId);

      if (alreadySaved) {
        memberSet.remove(myId);
        userMemberList.remove(myId);
      } else {
        memberSet.add(myId);
        userMemberList.add(myId);
      }
      await _partyRepository.joinParty(
          party: _party, memberList: userMemberList);

      emit(PartyDetailSuccessState());
    } catch (_) {
      emit(PartyDetailFailState());
    }
  }

  Future<void> closeParty() async {
    try {
      await _partyRepository.deleteParty(party: _party);
      emit(PartyDetailSuccessState());
    } catch (_) {
      emit(PartyDetailFailState());
    }
  }
}
