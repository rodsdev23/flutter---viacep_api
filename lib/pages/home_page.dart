import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:apicepviaback4app/repositories/busca_ceps_repository.dart';
import 'package:flutter/material.dart';

import 'buscacep_cadastrar_cep.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(key: key); // Correção na declaração do construtor

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CepsBuscaCepsRepository cepsBuscaCepsRepository;

  CepsBuscaCepsModel _cepsBuscaCeps =
      CepsBuscaCepsModel([]); // começa com vazio

  TextEditingController cepController = TextEditingController();
  bool carregando = false;

  @override
  void initState() {
    cepsBuscaCepsRepository = CepsBuscaCepsRepository();
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    setState(() {
      carregando = true;
    });
    var ceps = await cepsBuscaCepsRepository.obterTodosCeps();
    setState(() {
      _cepsBuscaCeps = CepsBuscaCepsModel(
          ceps.results); // Atualize o objeto com a nova lista
      carregando = false;
    });
  }

  pesquisarCep(String cep) async {
    setState(() {
      carregando = true;
    });
    await cepsBuscaCepsRepository.pesquisarCep(cep);

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Consulta Ceps - Back4App',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: cepController,
                  decoration: const InputDecoration(labelText: "Digite o CEP"),
                  onChanged: (value) async {
                    final inputCep = cepController.text;

                    if (inputCep.isNotEmpty) {
                      setState(() {
                        _cepsBuscaCeps.results = [];
                        carregando = true;
                      });

                      var result =
                          await cepsBuscaCepsRepository.pesquisarCep(inputCep);

                      // Filtrar os resultados de acordo com o CEP desejado
                      var cepFiltrado = result.results
                          .where((cep) => cep.cep == inputCep)
                          .toList();

                      setState(() {
                        _cepsBuscaCeps.results = cepFiltrado;
                        carregando = false;
                      });
                    }
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: const Text("Buscar"),
                    onPressed: () async {
                      var verificarCepController =
                          double.parse(cepController.text);
                      if (verificarCepController >= 8) {
                        setState(() {
                          _cepsBuscaCeps.results = [];

                          carregando = true;
                        });
                        final inputCep = cepController.text;
                        if (inputCep.isNotEmpty &&
                            double.tryParse(inputCep) != null) {
                          final parsedCep = double.parse(inputCep);
                          await pesquisarCep(parsedCep.toString());
                        } else {
                          showDialog<AlertDialog>(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('CEP inválido!'),
                                        ],
                                      ),
                                    ),
                                  ));
                        }
                      }
                    }),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BuscaCepCadastrarCep()));
                  },
                  child: const Text("Cadastrar CEP"),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _cepsBuscaCeps.results.length,
                itemBuilder: (_, index) {
                  var cep = _cepsBuscaCeps.results[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 2,
                    shadowColor: Colors.grey[300]!,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 20,
                        child: Text(
                          cep.objectId!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(cep.cep!),
                      subtitle: Text(
                        '${cep.logradouro} - ${cep.bairro} - ${cep.localidade} / ${cep.uf}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.redAccent,
                        iconSize: 30,
                        onPressed: () {
                          // faça a logica para deletar
                          setState(() {
                            _cepsBuscaCeps.results.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
