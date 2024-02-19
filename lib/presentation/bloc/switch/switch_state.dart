part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchValiue;
  const SwitchState({required this.switchValiue});

  @override
  List<Object> get props => [switchValiue];
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required super.switchValiue});
}
