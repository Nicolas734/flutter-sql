import 'dart:math';

import 'package:flutter/material.dart';


import 'inicio.dart';

class HistoricoUsuario extends StatefulWidget {
  final String usuario;
  final String tecnico;
  final String graduacao;
  final String especializacao;

  const HistoricoUsuario({
    Key? key,
    required this.usuario,
    required this.tecnico,
    required this.graduacao,
    required this.especializacao,
  }) : super(key: key);

  @override
  HistoricoUsuarioState createState() => HistoricoUsuarioState(
      usuario: usuario,
      tecnico: tecnico,
      graduacao: graduacao,
      especializacao: especializacao);
}

class HistoricoUsuarioState extends State<HistoricoUsuario> {
  Color textColor = Colors.black;
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  final TextEditingController _usuario;
  final TextEditingController _tecnico;
  final TextEditingController _graduacao;
  final TextEditingController _especializacao;

  HistoricoUsuarioState(
      {required String usuario,
      required String tecnico,
      required String graduacao,
      required String especializacao})
      : _usuario = TextEditingController(text: usuario),
        _tecnico = TextEditingController(text: tecnico),
        _graduacao = TextEditingController(text: graduacao),
        _especializacao = TextEditingController(text: especializacao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50.0),
            Text('Usuario: ${_usuario.text}', style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0), // Espaçamento entre os textos
            Text('Informações:', style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            Text('Tecnico: ${_tecnico.text}', style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            Text('Graduacao: ${_graduacao.text}',
                style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            Text('Especialização: ${_especializacao.text}',
                style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 50.0),
            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Inicio(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 20),
                ),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
