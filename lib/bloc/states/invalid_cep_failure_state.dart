import 'package:bloc_example/bloc/states/cep_information_states.dart';

class InvalidCepFailureState implements CepInformationStates {
  final String errorMessage;

  InvalidCepFailureState({required this.errorMessage});
}
