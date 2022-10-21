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
      _partyListSubscription = _partyRepository
          .fetchPartyList(_user)
          .listen((event) => emit(HomeState(partyList: event)));
    } catch (_) {}
  }

  Future<void> dispose() async {
    _partyListSubscription?.cancel();
  }
}
