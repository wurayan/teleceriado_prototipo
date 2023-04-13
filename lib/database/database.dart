import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = '$dbPath/series.db';
  return openDatabase(path, onCreate: (db, version) {
    db.execute(
      'CREATE TABLE series (nome VARCHAR(100) NOT NULL PRIMARY KEY, imagemUrl TEXT, descricao TEXT, avaliacao INT(11))'
    );
    db.execute(
      'CREATE TABLE episodios (id INT NOT NULL PRIMARY KEY, idSerie INT NOT NULL, nome VARCHAR(100), imagemUrl TEXT, descricao TEXT, FOREIGN KEY (idSerie) REFERENCES series (nome))'
    );
  }, version: 1);
}
