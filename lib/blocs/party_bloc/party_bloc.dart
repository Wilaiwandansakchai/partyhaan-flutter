import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'party_event.dart';
part 'party_state.dart';

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  PartyBloc() : super(PartyInitial()) {
    on<PartyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
