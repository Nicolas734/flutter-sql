import 'package:flutter/material.dart';
import 'form_graduacao.dart';

class ListagemProdutos extends StatefulWidget {
  final String usuario;

  const ListagemProdutos({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  FormsState createState() => FormsState(usuario: usuario);
}

class FormsState extends State<ListagemProdutos> {
  final TextEditingController _usuario;
  List<int> selecionadosIndices = [];

  FormsState({required String usuario})
      : _usuario = TextEditingController(text: usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selecionar Produto',
                style: TextStyle(fontSize: 25.0, color: Colors.blue)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: ListView.builder(
                  itemCount: 5, // Número fixo de itens para paginação
                  itemBuilder: (BuildContext context, int index) {
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
                                Text('Item ${index + 1}',
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
                    tecnicosSelecionados.add("Item ${index + 1}");
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioGraduacao(
                      usuario: _usuario.text,
                      tecnicos: tecnicosSelecionados, tecnico: '',
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
