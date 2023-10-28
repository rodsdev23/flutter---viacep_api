import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:apicepviaback4app/pages/buscacep_editar_cep.dart.dart';
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
    // pega todos os ceps
    var ceps = await cepsBuscaCepsRepository.obterTodosCeps();
    setState(() {
      _cepsBuscaCeps = CepsBuscaCepsModel(
          ceps.results); // Atualize o objeto com a nova lista
      carregando = false;
    });
  }

  Future<void> pesquisarECarregarCeps(String inputCep) async {
    setState(() {
      _cepsBuscaCeps.results.clear(); // Limpa os resultados existentes
      carregando = true;
    });
    if (inputCep != '') {
      var resultadosPesquisa =
          await cepsBuscaCepsRepository.pesquisarCep(inputCep);
      setState(() {
        _cepsBuscaCeps.results
            .addAll(resultadosPesquisa.results); // Adiciona novos resultados
        carregando = false;
      });
    } else {
      obterCeps();
    }
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
                  keyboardType: TextInputType.number,
                  controller: cepController,
                  decoration: const InputDecoration(labelText: "Digite o CEP"),
                  onChanged: (value) async {
                    final inputCep = value;
                    if (cepController.text.isEmpty) {
                      obterCeps();
                    }

                    if (inputCep != "" &&
                        double.parse(inputCep) >= 1 &&
                        double.parse(inputCep) <= 8) {
                      if (inputCep.isNotEmpty) {
                        setState(() {
                          _cepsBuscaCeps.results = [];
                          carregando = true;
                        });
                      }

                      setState(() {
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
                    final inputCep = cepController.text;
                    if (inputCep.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, insira um CEP válido.'),
                        ),
                      );
                    } else {
                      setState(() {
                        _cepsBuscaCeps.results = [];
                        carregando = true;
                      });

                      try {
                        await pesquisarECarregarCeps(inputCep);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao buscar o CEP: $error'),
                          ),
                        );
                      } finally {
                        setState(() {
                          carregando = false;
                        });
                      }
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    carregando = true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BuscaCepCadastrarCepPage()));
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
                        '${cep.logradouro} \n ${cep.bairro} \n ${cep.localidade} / ${cep.uf}',
                      ),
                      trailing: PopupMenuButton<PopupMenuOptions>(
                        onSelected: (value) {
                          // editar cep
                          if (value == PopupMenuOptions.editar) {
                            Navigator.of(context).pop();

                            // Obtenha o CEP que deseja editar
                            var objectId =
                                _cepsBuscaCeps.results[index].objectId;
                            var cep = _cepsBuscaCeps.results[index].cep;
                            var logradouro =
                                _cepsBuscaCeps.results[index].logradouro;
                            var complemento =
                                _cepsBuscaCeps.results[index].complemento;
                            var bairro = _cepsBuscaCeps.results[index].bairro;
                            var localidade =
                                _cepsBuscaCeps.results[index].localidade;
                            var uf = _cepsBuscaCeps.results[index].uf;

                            // Crie um objeto CepsBuscaCepsModel com o valor do 'cep'
                            var cepModel = CepsBuscaCepsModel([
                              CepBuscaCepsModelAPI(
                                objectId: objectId,
                                cep: cep,
                                logradouro: logradouro,
                                complemento: complemento,
                                bairro: bairro,
                                localidade: localidade,
                                uf: uf,
                              )
                            ]);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BuscaCepEditarCepPage(
                                  cep: cepModel,
                                  cepsRepository: cepsBuscaCepsRepository,
                                ),
                              ),
                            ).then((result) {
                              if (result == true) {
                                // Atualize a lista de CEPs após a edição bem-sucedida
                                obterCeps();
                              }
                            });
                          }

                          // excluir cep
                          if (value == PopupMenuOptions.excluir) {
                            showDialog<bool>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                      'Tem certeza que deseja excluir?'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Obtenha o ID do CEP que deseja excluir
                                        var cepId = _cepsBuscaCeps
                                            .results[index].objectId;

                                        // Exiba um CircularProgressIndicator enquanto aguarda a exclusão
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        // Realize a exclusão
                                        if (cepId != null) {
                                          await cepsBuscaCepsRepository
                                              .deletarCep(cepId);
                                        }

                                        // Após a exclusão, feche o diálogo e atualize a lista
                                        Navigator.pop(
                                            context); // Fecha o diálogo de progresso
                                        Navigator.pop(context,
                                            true); // Fecha o diálogo de confirmação

                                        setState(() {
                                          // Remova da lista
                                          _cepsBuscaCeps.results
                                              .removeAt(index);
                                        });
                                      },
                                      child: const Text('Sim'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Não'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<PopupMenuOptions>>[
                          const PopupMenuItem<PopupMenuOptions>(
                            value: PopupMenuOptions.editar,
                            child: Text('Editar'),
                          ),
                          const PopupMenuItem<PopupMenuOptions>(
                            value: PopupMenuOptions.excluir,
                            child: Text('Excluir'),
                          ),
                        ],
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

_close(BuildContext context) {
  // Após a exclusão, feche o diálogo e atualize a lista
  Navigator.pop(context); // Fecha o diálogo de progresso
  Navigator.pop(context, true); // Fecha o diálogo de confirmação
}

void _excluirCep(BuildContext context, int index) {}

enum PopupMenuOptions {
  editar,
  excluir,
}
