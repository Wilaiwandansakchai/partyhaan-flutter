import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/party_model.dart';
import '../../../repositories/party_repository.dart';

part 'create_party_state.dart';

class CreatePartyCubit extends Cubit<CreatePartyState> {
  final PartyRepository _partyRepository;

  CreatePartyCubit(this._partyRepository) : super(CreatePartyInitial());

  Future<void> createParty() async {
    try {
      await _partyRepository.createParty(
          party: Party(
              createDate: Timestamp.now(),
              count: 0,
              maxCount:5,
              image: "https://files.vogue.co.th/uploads/Natural_cosmetic.jpg",
              mode: "mode",
              name: "name",
              price: 300,
              title: "title"));

      emit(CreateSuccessState());
    } catch (_) {}
  }
}
