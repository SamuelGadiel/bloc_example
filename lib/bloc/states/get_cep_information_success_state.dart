import 'package:bloc_example/bloc/states/cep_information_states.dart';

class GetCepInformationSuccessState implements CepInformationStates {
  final String city;
  final String state;

  GetCepInformationSuccessState({required this.city, required this.state});
}
