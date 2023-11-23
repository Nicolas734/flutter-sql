// ignore: file_names
import 'package:flutter/material.dart';

import 'form_especializacao.dart';


// ignore: camel_case_types
class FormularioGraduacao extends StatefulWidget {
  final String usuario;
  final String tecnico;

  const FormularioGraduacao({
    Key? key,
    required this.usuario,
    required this.tecnico,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(usuario: usuario, tecnico:tecnico);
}

List<dynamic> data = [
  {"id": 1, "name": "Desenvolvimento de software multiplataforma"},
  {"id": 2, "name": "Ciencia da computação"},
  {"id": 3, "name": "Engenharia da computação"},
];

class FormsState extends State<FormularioGraduacao> {
  final TextEditingController _usuario;
  final TextEditingController _tecnico;
  final TextEditingController _anoConclusaoGraduacao = TextEditingController();
  int selecionadoIndex = -1;

  FormsState({required String usuario, required String tecnico})
      : _usuario = TextEditingController(text: usuario),
        _tecnico = TextEditingController(text:tecnico);

  Color textColor = Colors.black; // default color
  Color textColorWarning = Colors.grey; // default color
  Color borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50.0),
            Text('Usuario: ${_usuario.text}',
                style: const TextStyle(fontSize: 25.0, color: Colors.blue)),
            const SizedBox(height: 50.0),
            const Text('Selecionar Graduação',
                style: TextStyle(fontSize: 25.0, color: Colors.blue)),
            Expanded(
              // Wrap the ListView.builder with Expanded
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selecionadoIndex =
                              index; // Atualiza o índice selecionado
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selecionadoIndex == index
                                ? Colors.blue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item['name']}',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text("Ano de conclusão", style: TextStyle(fontSize: 25.0, color: Colors.blue)),
            const SizedBox(height: 10.0),
            TextField(
                controller: _anoConclusaoGraduacao,
                keyboardType: TextInputType.number,
                decoration: const  InputDecoration(
                  hintText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String graduacaoSelecionada = "";

                if (selecionadoIndex != -1) {
                  graduacaoSelecionada = data[selecionadoIndex]["name"];
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioEspecializacao(
                        usuario: _usuario.text, tecnico: _tecnico.text, graduacao: graduacaoSelecionada, quantidades: [], graduacoes: [],),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 50),
              ),
              child: const Text('Avançar'),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
