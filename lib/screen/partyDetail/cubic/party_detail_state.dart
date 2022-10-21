part of 'party_detail_cubit.dart';

enum UserStatus { none, join, host }

class PartyDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PartyDetailSuccessState extends PartyDetailState {}

class PartyDetailFailState extends PartyDetailState {}
