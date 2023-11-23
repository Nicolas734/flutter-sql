import 'package:flutter/material.dart';
import 'form_graduacao.dart';

class FormularioTecnico extends StatefulWidget {
  final String usuario;

  const FormularioTecnico({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(usuario: usuario);
}

List<dynamic> data = [
  {"id": 1, "name": "Informatica"},
  {"id": 2, "name": "Automação"},
  {"id": 3, "name": "Administração"},
];

class FormsState extends State<FormularioTecnico> {
  final TextEditingController _usuario;
  final TextEditingController _anoConclusao = TextEditingController();
  List<int> selecionadosIndices = [];

  FormsState({required String usuario})
      : _usuario = TextEditingController(text: usuario);

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
            const Text('Selecionar Produto',
                style: TextStyle(fontSize: 25.0, color: Colors.blue)),
            Expanded(
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
                          if (selecionadosIndices.contains(index)) {
                            selecionadosIndices.remove(index);
                          } else {
                            selecionadosIndices.add(index);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selecionadosIndices.contains(index)
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                List<String> tecnicosSelecionados = [];

                if (selecionadosIndices.isNotEmpty) {
                  for (int index in selecionadosIndices) {
                    tecnicosSelecionados.add(data[index]["name"]);
                  }
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioGraduacao(
                      usuario: _usuario.text,
                      tecnicos: tecnicosSelecionados,
                    ),
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

// Adicione a classe FormularioGraduacao com os ajustes necessários para aceitar uma lista de técnicos
class FormularioGraduacao extends StatelessWidget {
  final String usuario;
  final List<String> tecnicos;

  const FormularioGraduacao({
    Key? key,
    required this.usuario,
    required this.tecnicos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Graduação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario: $usuario'),
            Text('Técnicos Selecionados: ${tecnicos.join(', ')}'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FormularioTecnico(usuario: 'ExemploUsuario'),
  ));
}
