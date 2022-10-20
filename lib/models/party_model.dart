import 'package:cloud_firestore/cloud_firestore.dart';

class Party {
  final Timestamp createDate;

  final String image;
  final String name;
  final String product;
  final int maxCount;
  final int count;
  final int price;

  final List<String> member;
  final String host;

  Party(
      {required this.createDate,
      required this.image,
      required this.name,
      required this.product,
      required this.maxCount,
      required this.count,
      required this.price,
      required this.member,
      required this.host});

  List<Object> get props =>
      [createDate, image, name, product, maxCount, count, price, member, host];

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  Map<String, dynamic> toJson() => _$PartyToJson(this);
}

Party _$PartyFromJson(Map<String, dynamic> json) {
  return Party(
    createDate: json['createDate'] as Timestamp,
    image: json['image'] as String,
    name: json['name'] as String,
    product: json['product'] as String,
    maxCount: json['maxCount'] as int,
    count: json['count'] as int,
    price: json['price'] as int,
    member: (json['member'] as List<dynamic>).map((e) => "$e").toList(),
    host: json['host'] as String,
  );
}

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      "createDate": Timestamp.now(),
      "image": instance.image,
      "name": instance.name,
      "product": instance.product,
      "maxCount": instance.maxCount,
      "price": instance.price,
      "member": instance.member,
      "host": instance.host
    };
