import 'dart:io';

import '../models/create_party_model.dart';
import '../models/party_model.dart';
import '../models/user_model.dart';
import '../services/party_service.dart';

class PartyRepository {
  final PartyServiceImpl _apiService = PartyServiceImpl();

  Stream<List<Party>> fetchPartyList(User user) {
    return _apiService.partyList.map((partyList) {
      final myId = user.id;
      return partyList.map((e) {
        final Party party = e;
        final List<String> userMemberList = party.member;
        final Set<String> memberSet = userMemberList.map((e) => e).toSet();
        final bool isMember = memberSet.contains(myId);
        party.isHost = user.id == party.host;
        party.isMember = isMember;

        int countMember = 1 + party.member.length;
        int dividePrice = (party.price / party.maxCount ).toInt();
        party.countMember = countMember ;
        party.dividePrice = dividePrice;
        return party;
      }).toList();
    });
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
