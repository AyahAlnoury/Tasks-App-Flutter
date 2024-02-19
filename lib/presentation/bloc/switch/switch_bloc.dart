import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValiue: false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(SwitchState(switchValiue: true));
    });

    on<SwitchOffEvent>((event, emit) {
      emit(SwitchState(switchValiue: false));
    });
  }
}
