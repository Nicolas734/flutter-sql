import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

import 'form_tecnico.dart';


class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  Color textColor = Colors.black;
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

    final TextEditingController _usuario = TextEditingController();
    final TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Torna o container circular
                image: DecorationImage(
                  image: AssetImage('assets/images/flutter.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
             const Text(
              'Usuario',
              style: TextStyle(fontSize: 28.0, color: Colors.blue),
            ),
            TextField(
                controller: _usuario,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Usuario", // Use o valor do _nome como hintText
                  prefixIcon: Icon(Icons.account_circle_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
               const Text(
              'Senha',
              style: TextStyle(fontSize: 28.0, color: Colors.blue),
            ),
              TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: _senha,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Entre com a senha",
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
            const SizedBox(height: 50.0),
            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioTecnico(usuario:_usuario.text),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 20),
                ),
                child: const Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
