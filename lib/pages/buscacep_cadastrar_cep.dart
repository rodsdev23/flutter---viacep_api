import 'package:apicepviaback4app/models/busca_ceps_model.dart';
import 'package:apicepviaback4app/pages/home_page.dart';
import 'package:apicepviaback4app/repositories/busca_ceps_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class BuscaCepCadastrarCepPage extends StatefulWidget {
  const BuscaCepCadastrarCepPage({Key? key}) : super(key: key);

  @override
  State<BuscaCepCadastrarCepPage> createState() =>
      _BuscaCepCadastrarCepPageState();
}

class _BuscaCepCadastrarCepPageState extends State<BuscaCepCadastrarCepPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController localidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();

  CepsBuscaCepsRepository _cepsBuscaCepsRepository = CepsBuscaCepsRepository();
  List<CepsBuscaCepsModel> listaResults = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Cadastrar CEP')),
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
                              child: const Text('Enviar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetFormulario,
                              child: Text(
                                'Reiniciar',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
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
      print('Dados do formulário: $formData');
      if (formData != null) {
        // Preencha os controladores com os valores do formulário
        cepController.text = formData['cep'];
        logradouroController.text = formData['logradouro'];
        complementoController.text = formData['complemento'];
        bairroController.text = formData['bairro'];
        localidadeController.text = formData['localidade'];
        ufController.text = formData['uf'];

        // Crie uma instância do modelo com os valores dos controladores
        var cepBuscaCepsModelAPI = CepBuscaCepsModelAPI(
          cep: cepController.text,
          logradouro: logradouroController.text,
          complemento: complementoController.text,
          bairro: bairroController.text,
          localidade: localidadeController.text,
          uf: ufController.text,
        );

        try {
          await _cepsBuscaCepsRepository.criar(cepBuscaCepsModelAPI);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Formulário enviado com sucesso!')),
          );
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
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

  void _resetFormulario() {
    _formKey.currentState?.reset();
  }
}
