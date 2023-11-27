import 'package:flutter/material.dart';
import 'package:flutter_sqlite/database/db.dart';
import 'package:flutter_sqlite/form_tecnico.dart';
import 'package:flutter_sqlite/model/usuario.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  late DB _database;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  _initDatabase() async {
    try {
      _database = DB();
      print("Opening the database...");
      await _database.openDatabaseConnection();
      print("Database connection successful!");
      await findUsers();
    } catch (error) {
      print("Error opening the database: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  findUsers() async {
    try {
      print("Fetching users...");
      List<Usuario> data = await _database.getAllUsuarios();

    } catch (error) {
      print("Error fetching users: $error");
    }
  }

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
                shape: BoxShape.circle,
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
                hintText: "Usuario",
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
              decoration: const InputDecoration(
                hintText: "Entre com a senha",
                prefixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
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
                      builder: (context) =>
                          FormularioTecnico(usuario: _usuario.text),
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
