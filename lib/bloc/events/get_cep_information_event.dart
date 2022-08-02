import 'package:bloc_example/bloc/events/cep_information_events.dart';

class GetCepInformationEvent implements CepInformationEvents {
  final String cep;

  GetCepInformationEvent(this.cep);
}
