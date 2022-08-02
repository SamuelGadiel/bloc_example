import 'package:bloc_example/bloc/states/cep_information_states.dart';

class GetCepInformationFailureState implements CepInformationStates {
  final String errorMessage;

  GetCepInformationFailureState({required this.errorMessage});
}
