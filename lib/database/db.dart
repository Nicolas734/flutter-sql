import "package:flutter_sqlite/model/usuario.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class DB {
  late Database _database;

  late List<String> inserts = [
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(1,'Nicolas', 'nicolas@gmail.com', 'senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(2,'Rodrigo', 'rodrigo@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(3,'Raniel', 'raniel@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(4,'Natalia', 'natalia@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(5,'Rafael', 'rafael@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(6,'Kevin', 'kevin@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(7,'Vinicius', 'vinicius@gmail.com','senha')",
    "INSERT INTO usuarios(id, nome, email, senha) VALUES(8,'Antonio', 'antonio@gmail.com','senha')",
  ];

  Future<void> openDatabaseConnection() async {
    final String path = join(await getDatabasesPath(), 'database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE usuarios(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              nome TEXT, 
              email TEXT, 
              senha TEXT
            )
          ''',
        );

        await db.execute('''
          CREATE TABLE produtos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            nome TEXT,
            descricao Text,
            preco INTEGER,
            quantidade INTEGER
          )
      ''');

        await db.execute('''
          CREATE TABLE compras(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_usuario INTEGER,
            id_produto INTEGER
          )
      ''');
      },
    );
    print("Executando inserts...");
    // for (int i = 0; i < inserts.length; i++) {
    //   String query = inserts[i];
    //   await _database.execute(query);
    // }
    getProducts();
  }

  Future<List<Usuario>> getAllUsuarios() async {
    final List<Map<String, dynamic>> maps = await _database.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          email: maps[i]["email"],
          senha: maps[i]['senha']);
    });
  }

  Future<void> getProducts() async {
    final response = await http.get(Uri.parse(
        'https://loja-mcyhir2om-rodrigoribeiro027.vercel.app/produtos/buscar'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        print(jsonResponse[i]);
        String query =
            "INSERT INTO produtos(nome,descricao, preco, quantidade) VALUES('${jsonResponse[i]['nome']}','${jsonResponse[i]['descricao']}', ${jsonResponse[i]['preco']}, ${jsonResponse[i]['quantidade']})";
        await _database.execute(query);
      }
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
