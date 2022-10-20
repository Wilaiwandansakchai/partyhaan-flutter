part of 'create_party_cubit.dart';

@immutable
abstract class CreatePartyState {}

class CreatePartyInitial extends CreatePartyState {}

class CreateSuccessState extends CreatePartyState {}

class CreateFailState extends CreatePartyState {}
