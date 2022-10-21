import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partyhaan/models/create_party_model.dart';

import '../../../models/user_model.dart';
import '../../../repositories/party_repository.dart';

part 'create_party_state.dart';

class CreatePartyCubit extends Cubit<CreatePartyState> {
  final PartyRepository _partyRepository;
  final User _user;

  CreatePartyCubit(this._partyRepository, {required User user})
      : _user = user,
        super(CreatePartyState.initial());

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

  void imageChanged() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) throw "e";
      emit(
          state.copyWith(image: image.path, status: CreatePartyStatus.initial));
    } catch (_) {
      emit(state.copyWith(status: CreatePartyStatus.error));
    }
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
        image: state.image!,
        host: _user.id,
      ));
      emit(state.copyWith(status: CreatePartyStatus.success));
    } catch (_) {}
  }
}
