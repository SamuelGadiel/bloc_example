import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Neste arquivo você encontra as informações originais da tela, sem o uso do BLoC.

class OldHomePage extends StatefulWidget {
  const OldHomePage({Key? key}) : super(key: key);

  @override
  State<OldHomePage> createState() => _OldHomePageState();
}

class _OldHomePageState extends State<OldHomePage> {
  final cepController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';
  Map cepData = {};

  getCepData(String cep) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      cepData.clear();
    });

    try {
      final url = 'https://viacep.com.br/ws/$cep/json';
      final response = await Dio().get(url);

      setState(() {
        cepData = response.data;
      });
    } catch (e) {
      errorMessage = 'Ocorreu um erro na pesquisa';
    }

    setState(() {
      isLoading = false;
    });
  }

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
                  if (cepController.text.length != 8) {
                    setState(() {
                      errorMessage = 'CEP deve ter 8 dígitos';
                    });
                  } else {
                    getCepData(cepController.text);
                  }
                },
              ),
            ),
            const SizedBox(height: 40),

            // DADOS DO CEP
            Builder(
              builder: ((context) {
                if (isLoading) return const CircularProgressIndicator();

                if (errorMessage.isNotEmpty) {
                  return Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                if (cepData.isEmpty) return Container();

                return Column(
                  children: [
                    Text(
                      'Cidade: ${cepData['localidade']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Estado: ${cepData['uf']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
