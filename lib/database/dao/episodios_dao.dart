
import 'package:sqflite/sqflite.dart';
import 'package:teleceriado/database/database.dart';
import 'package:teleceriado/models/episodios.dart';

class EpisodiosDao {
  Future<List<Episodios>> findAllEpisodios(String idSerie) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('episodios', where: 'idSerie = "$idSerie"');
    List<Episodios> episodiosList = toList(result);
    return episodiosList;
  }

  Future<dynamic> saveEpisodio(String idSerie, Episodios episodio)async{
    final Database db = await getDatabase();
    Map<String, dynamic> episodioMap = toMap(episodio);
    return db.insert('episodios', episodioMap);
  }

  Future<dynamic> deleteEpisodio(String idSerie, int id ) async {
    final Database db = await getDatabase();
    return await db.delete('episodios', where: 'id = $id AND idSerie = "$idSerie"');
  }

  List<Episodios> toList(List<Map<String, dynamic>> result){
    final List<Episodios> episodiosList = [];
    for (Map<String, dynamic> row in result){
      final Episodios episodio = Episodios();
      episodio.id = row['id'];
      episodio.nome = row['nome'];
      episodio.imagemUrl = row['imagemUrl'];
      episodio.descricao = row['descricao'];
      episodiosList.add(episodio);
    }
    return episodiosList;
  }

  Map<String, dynamic> toMap (Episodios episodio){
    final Map<String,dynamic> episodioMap = {};
    episodioMap['id'] = episodio.id;
    episodioMap['idSerie'] = episodio.idSerie;
    episodioMap['nome'] = episodio.nome;
    episodioMap['imagemUrl'] = episodio.imagemUrl;
    episodioMap['descricao'] = episodio.descricao;
    return episodioMap;
  }
}