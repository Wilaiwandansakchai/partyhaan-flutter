import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/repositories/party_repository.dart';

import '../../../models/party_model.dart';
import '../../../models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PartyRepository _partyRepository;
  final User _user;
  StreamSubscription<List<Party>>? _partyListSubscription;

  HomeCubit(this._partyRepository, {required User user})
      : _user = user,
        super(HomeState.initial());

  Future<void> fetchPartyList() async {
    try {
      _partyListSubscription = _partyRepository.partyList.map((partyList) {
        final myId = _user.id;
        return partyList.map((e){
          final Party party = e;
          final List<String> userMemberList = party.member;
          final Set<String> memberSet = userMemberList.map((e) => e).toSet();
          final bool isMember = memberSet.contains(myId);
          party.isHost = _user.id == party.host;
          party.isMember = isMember;
          return party;
        }).toList();
      }).listen((event) => emit(HomeState(partyList: event)));
    } catch (_) {}
  }
}
