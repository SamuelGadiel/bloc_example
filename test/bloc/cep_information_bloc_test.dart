import 'package:bloc_example/bloc/cep_information_bloc.dart';
import 'package:bloc_example/bloc/events/get_cep_information_event.dart';
import 'package:bloc_example/bloc/states/get_cep_information_failure_state.dart';
import 'package:bloc_example/bloc/states/get_cep_information_loading_state.dart';
import 'package:bloc_example/bloc/states/get_cep_information_success_state.dart';
import 'package:bloc_example/bloc/states/invalid_cep_failure_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final bloc = CepInformationBloc();

  const validCep = '38414344';
  const invalidCep = '123';
  const errorCep = '00000000';

  test('Must emit a success state on valid cep', () {
    bloc.add(GetCepInformationEvent(validCep));

    expect(
      bloc.stream,
      emitsInOrder([
        isA<GetCepInformationLoadingState>(),
        isA<GetCepInformationSuccessState>(),
      ]),
    );
  });

  test('Must emit a invalid cep state on invalid cep', () {
    bloc.add(GetCepInformationEvent(invalidCep));

    expect(
      bloc.stream,
      emitsInOrder([
        isA<GetCepInformationLoadingState>(),
        isA<InvalidCepFailureState>(),
      ]),
    );
  });

  test('Must emit a failure state on error cep', () {
    bloc.add(GetCepInformationEvent(errorCep));

    expect(
      bloc.stream,
      emitsInOrder([
        isA<GetCepInformationLoadingState>(),
        isA<GetCepInformationFailureState>(),
      ]),
    );
  });
}
