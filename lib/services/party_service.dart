import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:partyhaan/models/create_party_model.dart';

import '../models/party_model.dart';
import 'firebase_service.dart';
import 'package:intl/intl.dart';

abstract class PartyService {
  Stream<List<Party>> get partyList;

  Future<void> createParty({required CreateParty createParty});

  Future<void> joinParty(
      {required Party party, required List<String> memberList});

  Future<void> deleteParty({required Party party});

  Future<String> uploadImage({required File imageFile});
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

  @override
  Future<String> uploadImage({required File imageFile}) async {
    try {
      DateFormat dateFormat = DateFormat("yyyyMMddHHmmss");
      String path = dateFormat.format(DateTime.now());

      Reference ref =
          FirebaseService().firestorage.ref().child('party/$path.jpg');

      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': imageFile.path});

      UploadTask uploadTask = ref.putFile(imageFile, metadata);
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      String url = imageUrl.toString();
      return url;
    } catch (e) {
      throw e.toString();
    }
  }
}
