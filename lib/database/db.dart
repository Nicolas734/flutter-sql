import "package:flutter_sqlite/model/usuario.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class DB {
  late Database _database;

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
            preco INT,
            quantidade INT
          )
      ''');

        await db.execute('''
          CREATE TABLE compras(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_usuario INT,
            id_produto INT
          )
      ''');
      },
    );


  }

    Future<List<Usuario>> getAllUsuarios() async {
      final List<Map<String, dynamic>> maps = await _database.query('usuario');
      return List.generate(maps.length, (i) {
        return Usuario(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          email: maps[i]["email"],
          senha: maps[i]['senha']
        );
      });
    }

}
