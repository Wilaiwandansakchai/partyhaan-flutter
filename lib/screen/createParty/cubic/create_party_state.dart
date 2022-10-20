part of 'create_party_cubit.dart';

enum CreatePartyStatus { initial, submitting, success, error }

class CreatePartyState extends Equatable {
  final String name;
  final String product;
  final int maxCount;
  final int price;
  final String image;
  final CreatePartyStatus status;

  const CreatePartyState(
      {required this.name,
      required this.product,
      required this.maxCount,
      required this.price,
      required this.image,
      required this.status});

  factory CreatePartyState.initial() {
    return const CreatePartyState(
        name: '',
        product: '',
        maxCount: 0,
        price: 0,
        image: '',
        status: CreatePartyStatus.initial);
  }

  @override
  List<Object?> get props => [name, product, maxCount, price, image, status];

  CreatePartyState copyWith(
      {String? name,
      String? product,
      int? maxCount,
      int? price,
      String? image,
      CreatePartyStatus? status}) {

    return CreatePartyState(
        name: name ?? this.name,
        product: product ?? this.product,
        maxCount: maxCount ?? this.maxCount,
        price: price ?? this.price,
        image: image ?? this.image,
        status: status ?? this.status);
  }
}
