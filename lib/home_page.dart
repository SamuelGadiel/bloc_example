import 'package:bloc_example/bloc/cep_information_bloc.dart';
import 'package:bloc_example/bloc/events/get_cep_information_event.dart';
import 'package:bloc_example/bloc/states/cep_information_states.dart';
import 'package:bloc_example/bloc/states/get_cep_information_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/states/get_cep_information_failure_state.dart';
import 'bloc/states/get_cep_information_success_state.dart';
import 'bloc/states/invalid_cep_failure_state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final cepController = TextEditingController();

  final cepBloc = CepInformationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Implementation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Insira um CEP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: TextField(
                controller: cepController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                child: const Text('Buscar dados', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  cepBloc.add(GetCepInformationEvent(cepController.text));
                },
              ),
            ),
            const SizedBox(height: 40),
            BlocBuilder<CepInformationBloc, CepInformationStates>(
              bloc: cepBloc,
              builder: (context, state) {
                if (state is GetCepInformationLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (state is InvalidCepFailureState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                if (state is GetCepInformationFailureState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                if (state is GetCepInformationSuccessState) {
                  return Column(
                    children: [
                      Text(
                        'Cidade: ${state.city}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Estado: ${state.state}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
