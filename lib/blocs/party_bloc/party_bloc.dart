import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:partyhaan/repositories/party_repository.dart';

import '../../models/party_model.dart';

part 'party_event.dart';

part 'party_state.dart';

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  final PartyRepository _partyRepository;

  PartyBloc({required PartyRepository partyRepository})
      : _partyRepository = partyRepository,
        super(const PartyState.updatePartyList([])) {
    on<PartyEvent>((event, emit) {
      on<FetchPartyList>(_onFetchPartyList);
      on<AddPartyListChange>(_onAddPartyListChange);
      // _partyListSubscription = _partyRepository.partyList.listen((event) =>
      // add(AddPartyListChange(event)));
    });
  }

  void _onFetchPartyList(FetchPartyList event, Emitter<PartyState> emit) async {
    // List<Party> partyList = await _partyRepository.fetchParty();
    // emit(PartyState.updatePartyList(partyList));
  }

  void _onAddPartyListChange(AddPartyListChange event,
      Emitter<PartyState> emit) {
    print("partyList event : ${event.partyList}");

    emit(PartyState.updatePartyList(event.partyList));
  }
}
