import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyhaan/models/create_party_model.dart';

import '../models/party_model.dart';
import 'firebase_service.dart';

abstract class PartyService {
  Stream<List<Party>> get partyList;

  Future<void> createParty({required CreateParty createParty});

  Future<void> joinParty(
      {required Party party, required List<String> memberList});

  Future<void> deleteParty({required Party party});
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
  Future<void> createParty({required CreateParty createParty}) {
    try {
      const String path = "events";
      return FirebaseService()
          .firestore
          .collection(path)
          .doc()
          .set(createParty.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> joinParty(
      {required Party party, required List<String> memberList}) async {
    try {
      const String path = "events";
      DocumentReference ref =
          FirebaseService().firestore.collection(path).doc(party.id);
      await ref.set({"member": memberList.toList()}, SetOptions(merge: true));
      return;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteParty({required Party party}) async {
    try {
      const String path = "events";
      DocumentReference ref =
          FirebaseService().firestore.collection(path).doc(party.id);
      await ref.delete();
      return;
    } catch (e) {
      throw e.toString();
    }
  }
}
