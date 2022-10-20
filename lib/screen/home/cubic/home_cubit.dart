import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:partyhaan/repositories/party_repository.dart';

import '../../../models/party_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PartyRepository _partyRepository;
  StreamSubscription<List<Party>>? _partyListSubscription;

  HomeCubit(this._partyRepository) : super(HomeState.initial());

  Future<void> fetchPartyList() async {
    try {
      _partyListSubscription = _partyRepository.partyList
          .listen((event) => emit(HomeState(partyList: event)));

    } catch (_) {}
  }

}
