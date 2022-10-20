import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/party_model.dart';
import 'firebase_service.dart';

abstract class PartyService {
  Stream<List<Party>> get partyList;
  Future<void> createParty({required Party party});
}

class PartyServiceImpl implements PartyService {
  @override
  Stream<List<Party>> get partyList {
    const String path = "events";
    return FirebaseService()
        .firestore
        .collection(path)
        .orderBy("createDate", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Party.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> createParty({required Party party}) {
    try {
      const String path = "events";
      return FirebaseService()
          .firestore
          .collection(path)
          .doc()
          .set(party.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

}
