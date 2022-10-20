part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Party> partyList;

  const HomeState({required this.partyList});

  @override
  List<Object> get props => [partyList];

  factory HomeState.initial() {
    return const HomeState(partyList: []);
  }
}
