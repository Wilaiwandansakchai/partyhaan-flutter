import '../models/create_party_model.dart';
import '../models/party_model.dart';
import '../services/party_service.dart';

class PartyRepository {
  final PartyServiceImpl _apiService = PartyServiceImpl();

  Stream<List<Party>> get partyList {
    return _apiService.partyList;
  }

  Future<void> createParty({required CreateParty createParty}) {
    return _apiService.createParty(createParty: createParty);
  }

  Future<void> joinParty({
    required Party party,
    required List<String> memberList,
  }) {
    return _apiService.joinParty(party: party, memberList: memberList);
  }
}
