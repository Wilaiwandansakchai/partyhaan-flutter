import 'dart:io';

import '../models/create_party_model.dart';
import '../models/party_model.dart';
import '../services/party_service.dart';

class PartyRepository {
  final PartyServiceImpl _apiService = PartyServiceImpl();

  Stream<List<Party>> get partyList {
    return _apiService.partyList;
  }

  Future<void> uploadImage({required File imageFile}) {
    return _apiService.uploadImage(imageFile: imageFile);
  }

  Future<void> createParty({required CreateParty createParty}) async {
    try {
      CreateParty party = createParty;
      final imageTemporary = File(createParty.image);
      String imagePath =
          await _apiService.uploadImage(imageFile: imageTemporary);
      party.imagePath = imagePath;
      return _apiService.createParty(createParty: createParty);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> joinParty({
    required Party party,
    required List<String> memberList,
  }) {
    return _apiService.joinParty(party: party, memberList: memberList);
  }

  Future<void> deleteParty({
    required Party party,
  }) {
    return _apiService.deleteParty(party: party);
  }
}
