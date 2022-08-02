import 'package:bloc_example/bloc/events/cep_information_events.dart';
import 'package:bloc_example/bloc/states/cep_information_initial_state.dart';
import 'package:bloc_example/bloc/states/cep_information_states.dart';
import 'package:bloc_example/bloc/states/get_cep_information_failure_state.dart';
import 'package:bloc_example/bloc/states/get_cep_information_loading_state.dart';
import 'package:bloc_example/bloc/states/get_cep_information_success_state.dart';
import 'package:bloc_example/bloc/states/invalid_cep_failure_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/get_cep_information_event.dart';

class CepInformationBloc extends Bloc<CepInformationEvents, CepInformationStates> {
  CepInformationBloc() : super(const CepInformationInitialState()) {
    on<GetCepInformationEvent>(_mapGetCepInformationEventToState);
  }

  Map cepData = {};

  void _mapGetCepInformationEventToState(GetCepInformationEvent event, Emitter<CepInformationStates> emit) async {
    emit(const GetCepInformationLoadingState());

    if (event.cep.length != 8) {
      emit(InvalidCepFailureState(errorMessage: 'CEP deve ter 8 dígitos'));
    } else {
      try {
        final url = 'https://viacep.com.br/ws/${event.cep}/json';
        final response = await Dio().get(url);

        cepData = response.data;

        final String city = cepData['localidade'];
        final String state = cepData['uf'];

        emit(GetCepInformationSuccessState(city: city, state: state));
      } catch (e) {
        emit(GetCepInformationFailureState(errorMessage: 'Ocorreu um erro ao buscar os dados do CEP'));
      }
    }
  }
}
