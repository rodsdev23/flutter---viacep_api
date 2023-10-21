import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:apicepviaback4app/repositories/busca_ceps_repository.dart';
import 'package:flutter/material.dart';

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
    final ceps = await cepsBuscaCepsRepository.obterTodosCeps();
    setState(() {
      _cepsBuscaCeps = CepsBuscaCepsModel(
          ceps.results); // Atualize o objeto com a nova lista
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
                  if (cepController.text.isNotEmpty) {
                    var ceps = await cepsBuscaCepsRepository.obterTodosCeps();
                    setState(() {
                      _cepsBuscaCeps.results =
                          ceps.results; // Atualize a lista com os dados obtidos
                    });
                  } else {
                    setState(() {
                      _cepsBuscaCeps.results.clear(); // Limpe a lista
                    });
                    // Você pode adicionar lógica adicional aqui, se necessário.
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                obterCeps(); // Chame a função obterCeps para buscar os CEPs
              },
              child: const Text("Buscar"),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _cepsBuscaCeps.results.length,
                itemBuilder: (_, index) {
                  //var cep = _cepsBuscaCeps.ceps. .!.results![index];
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
                      title: Text(cep.cep),
                      subtitle: Text(
                        '${cep.logradouro} - ${cep.bairro} - ${cep.localidade} / ${cep.uf}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.greenAccent,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            '${cep.objectId},${cep.cep},${cep.logradouro},${cep.bairro},${cep.localidade},${cep.uf}',
                          );
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
