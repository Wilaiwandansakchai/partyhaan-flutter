import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CreateParty extends Equatable {
  final String name;
  final String product;
  final int maxCount;
  final int price;
  final String image;
  final String host;
  String? imagePath;

  CreateParty(
      {required this.name,
      required this.product,
      required this.maxCount,
      required this.price,
      required this.image,
      this.imagePath,
      required this.host});

  Map<String, dynamic> toJson() => _$CreatePartyToJson(this);

  @override
  List<Object?> get props =>
      [name, product, maxCount, price, image, host, imagePath];
}

Map<String, dynamic> _$CreatePartyToJson(CreateParty instance) =>
    <String, dynamic>{
      "createDate": Timestamp.now(),
      "image": instance.imagePath,
      "name": instance.name,
      "product": instance.product,
      "maxCount": instance.maxCount,
      "price": instance.price,
      "member": [],
      "count": 0,
      "host": instance.host
    };
