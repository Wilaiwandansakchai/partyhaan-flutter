import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:partyhaan/models/create_party_model.dart';

import '../../../repositories/party_repository.dart';

part 'create_party_state.dart';

class CreatePartyCubit extends Cubit<CreatePartyState> {
  final PartyRepository _partyRepository;

  CreatePartyCubit(this._partyRepository) : super(CreatePartyState.initial());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: CreatePartyStatus.initial));
  }

  void productChanged(String value) {
    emit(state.copyWith(product: value, status: CreatePartyStatus.initial));
  }

  void maxCountChanged(int value) {
    emit(state.copyWith(maxCount: value, status: CreatePartyStatus.initial));
  }

  void priceChanged(int value) {
    emit(state.copyWith(price: value, status: CreatePartyStatus.initial));
  }

  void imageChanged(String value) {
    emit(state.copyWith(image: value, status: CreatePartyStatus.initial));
  }

  Future<void> createParty() async {
    if (state.status == CreatePartyStatus.submitting) return;
    emit(state.copyWith(status: CreatePartyStatus.submitting));
    try {
      await _partyRepository.createParty(
          createParty: CreateParty(
        name: state.name,
        maxCount: state.maxCount,
        price: state.price,
        product: state.product,
        image:
            "https://firebasestorage.googleapis.com/v0/b/partyhaan-e8a5c.appspot.com/o/imagecos.jpg?alt=media&token=efb90976-7861-48ae-9cd0-40f65f7fa1ff",
        host: '',
      ));
      emit(state.copyWith(status: CreatePartyStatus.success));
    } catch (_) {}
  }
}
