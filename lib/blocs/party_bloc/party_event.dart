part of 'party_bloc.dart';

@immutable
abstract class PartyEvent extends Equatable {
  const PartyEvent();

  @override
  List<Object?> get props => [];
}

class FetchPartyList extends PartyEvent {}

class AddPartyListChange extends PartyEvent {
  final List<Party> partyList;

  const AddPartyListChange(this.partyList);

  @override
  List<Object?> get props => [partyList];
}
