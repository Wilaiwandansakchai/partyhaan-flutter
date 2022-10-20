import 'package:cloud_firestore/cloud_firestore.dart';

class Party {
  final Timestamp createDate;
  final int count;
  final int maxCount;
  final String image;
  final String mode;
  final String name;
  final int price;
  final String title;

  Party(
      {required this.createDate,
      required this.count,
      required this.maxCount,
      required this.image,
      required this.mode,
      required this.name,
      required this.price,
      required this.title});

  List<Object> get props =>
      [createDate, count, image, mode, name, price, title, maxCount];

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  Map<String, dynamic> toJson() => _$PartyToJson(this);
}

Party _$PartyFromJson(Map<String, dynamic> json) {
  return Party(
    createDate: json['createDate'] as Timestamp,
    count: json['count'] as int,
    image: json['image'] as String,
    mode: json['mode'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    maxCount: json['maxCount'] as int,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      "createDate": Timestamp.now(),
      "count": instance.count,
      "image": instance.image,
      "mode": instance.mode,
      "name": instance.name,
      "maxCount": instance.maxCount,
      "price": instance.price,
      "title": instance.title
    };
