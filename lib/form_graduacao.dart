import 'package:flutter/material.dart';
import 'package:flutter_sqlite/form_tecnico.dart';
import 'package:flutter_sqlite/inicio.dart';
import 'form_especializacao.dart';

class FormularioGraduacao extends StatefulWidget {
  final String usuario;
  final String tecnico;

  const FormularioGraduacao({
    Key? key,
    required this.usuario,
    required this.tecnico,
    required List<String> tecnicos,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(usuario: usuario, tecnico: tecnico);
}

List<dynamic> data = [
  {"id": 1, "name": "Informatica", "preco": 105},
  {"id": 2, "name": "Automação", "preco": 105},
  {"id": 3, "name": "Administração", "preco": 105},
];

class FormsState extends State<FormularioGraduacao> {
  final TextEditingController _usuario;
  final TextEditingController _tecnico;
  final TextEditingController _anoConclusaoGraduacao = TextEditingController();
  List<int> quantidades = List.filled(data.length, 0);

  FormsState({required String usuario, required String tecnico})
      : _usuario = TextEditingController(text: usuario),
        _tecnico = TextEditingController(text: tecnico);

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
            const Text('Selecionar a quantidade',
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('${item['name']}',
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8.0),
                                  Text('Preço:'),
                                  Text('${item['preco']}',
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  const Text('Desconto: 5%'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Text('Quantidade:'),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          quantidades[index] = int.parse(value);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Inicio(
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 50),
                  ),
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Pedido Enviado Com Sucesso')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 50),
                  ),
                  child: const Text('Comprar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
