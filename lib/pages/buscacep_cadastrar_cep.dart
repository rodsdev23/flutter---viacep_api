import 'package:flutter/material.dart';

class BuscaCepCadastrarCep extends StatefulWidget {
  const BuscaCepCadastrarCep({super.key});

  @override
  State<BuscaCepCadastrarCep> createState() => _BuscaCepCadastrarCepState();
}

class _BuscaCepCadastrarCepState extends State<BuscaCepCadastrarCep> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Cadastrar CEP')),
      body: Column(
        children: [
          Text(" Instalar o Brasil ceps"),
        ],
      ),
    ));
  }
}
