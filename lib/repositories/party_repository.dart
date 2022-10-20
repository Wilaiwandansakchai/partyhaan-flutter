import '../models/party_model.dart';
import '../services/party_service.dart';

class PartyRepository {
  final PartyServiceImpl _apiService = PartyServiceImpl();

  Stream<List<Party>> get partyList {
    return _apiService.partyList;
  }

  Future<void> createParty({required Party party}) {
    return _apiService.createParty(party: party);
  }
}
