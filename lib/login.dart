import 'package:flutter/material.dart';
import 'package:flutter_sqlite/database/db.dart';
import 'package:flutter_sqlite/listagem_produtos.dart';
import 'package:flutter_sqlite/model/usuario.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late DB _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  _initDatabase() async {
    try {
      _database = DB.instance;
      print("Opening the database...");
      await _database.openDatabaseConnection();
      print("Database connection successful!");
    } catch (error) {
      print("Error opening the database: $error");
    }
  }

Future<bool> login(String email, String senha) async {
  try {
    List<Usuario> usuarios = await _database.getUserByEmailAndPassword(email, senha);
    if (usuarios.isNotEmpty) {
      return true;
    }
    return false;
  } catch (error) {
    print(error);
    return false;
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
                onPressed: () async {
                  bool ret = await login(_usuario.text, _senha.text);
                  if(ret){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListagemProdutos(selecionados: []),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login inválido, email ou senha incorretos!'),
                        backgroundColor: Color(Colors.red.value),
                      ),
                    );
                  }
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
