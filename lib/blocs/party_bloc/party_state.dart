part of 'party_bloc.dart';

class PartyState extends Equatable {
  final List<Party> partyList;

  const PartyState._({required this.partyList});

  const PartyState.updatePartyList(List<Party> partyList)
      : this._(partyList: partyList);

  @override
  List<Object?> get props => [partyList];
}
