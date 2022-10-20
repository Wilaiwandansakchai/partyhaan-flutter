import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_party_state.dart';

class CreatePartyCubit extends Cubit<CreatePartyState> {
  CreatePartyCubit() : super(CreatePartyInitial());
}
