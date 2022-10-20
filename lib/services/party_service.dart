import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/party_model.dart';
import 'firebase_service.dart';

abstract class PartyService {
  Stream<List<Party>> get partyList;
  Future<void> createParty({required Party party});
  Future<void> joinParty({required Party party});

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
        Party party = Party.fromJson(doc.data());
        party.id = doc.id;
        return party;
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

  @override
  Future<void> joinParty({required Party party}) {
    try {
      print("party id : ${party.id}");
      print("party name : ${party.name}");

      const String path = "events";
      // return FirebaseService()
      //     .firestore
      //     .collection(path)
      //     .doc()
      //     .set(party.toJson());
      throw "t";

    } catch (e) {
      throw e.toString();
    }
  }

}
