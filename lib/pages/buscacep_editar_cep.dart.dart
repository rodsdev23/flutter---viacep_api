import 'package:apicepviaback4app/pages/home_page.dart';
import 'package:apicepviaback4app/repositories/busca_ceps_repository.dart';
import 'package:flutter/material.dart';
import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BuscaCepEditarCepPage extends StatefulWidget {
  final CepsBuscaCepsModel cep;
  final CepsBuscaCepsRepository cepsRepository;

  const BuscaCepEditarCepPage({
    required this.cep,
    required this.cepsRepository,
  });

  @override
  _BuscaCepEditarCepPageState createState() => _BuscaCepEditarCepPageState();
}

class _BuscaCepEditarCepPageState extends State<BuscaCepEditarCepPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController localidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Preencha os controladores com os valores do CEP a ser editado
    cepController.text = widget.cep.results[0].cep ?? '';
    logradouroController.text = widget.cep.results[0].logradouro ?? '';
    complementoController.text = widget.cep.results[0].complemento ?? '';
    bairroController.text = widget.cep.results[0].bairro ?? '';
    localidadeController.text = widget.cep.results[0].localidade ?? '';
    ufController.text = widget.cep.results[0].uf ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Editar CEP')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField('cep', cepController, 'CEP'),
                      _buildTextField(
                          'logradouro', logradouroController, 'Logradouro'),
                      _buildTextField(
                          'complemento', complementoController, 'Complemento'),
                      _buildTextField('bairro', bairroController, 'Bairro'),
                      _buildTextField(
                          'localidade', localidadeController, 'Localidade'),
                      _buildTextField('uf', ufController, 'UF'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _enviarFormulario,
                              child: const Text('Salvar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomePage()));
                              },
                              child: const Text('Cancelar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String name, TextEditingController controller, String labelText) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  void _enviarFormulario() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formData = _formKey.currentState?.value;
      if (formData != null) {
        var cepId = widget.cep.results[0].objectId;

        if (cepId != null) {
          try {
            var cepModel = CepBuscaCepsModelAPI(
                objectId: cepId,
                cep: formData['cep'],
                logradouro: formData['logradouro'],
                complemento: formData['complemento'],
                bairro: formData['bairro'],
                localidade: formData['localidade'],
                uf: formData['uf'],
                updatedAt: formData['updatedAt'],
                createdAt: formData['createdAt']);

            await widget.cepsRepository.atualizarCEP(cepId, cepModel);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('Formulário enviado com sucesso!')),
            );
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao enviar o formulário: $error')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Falha na validação')),
          );
        }
      }
    }
  }
}
