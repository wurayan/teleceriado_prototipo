import 'package:sqflite/sqflite.dart';
import 'package:teleceriado/database/database.dart';
import 'package:teleceriado/models/series.dart';

class SeriesDao {
  
  Future<List<Series>> findAllSeries() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('series');
    List<Series> seriesList = toList(result);
    return seriesList;
  }

  Future<dynamic> saveSerie(Series serie) async {
    final Database db = await getDatabase();
    Map <String, dynamic> seriesMap = toMap(serie);
    return db.insert('series', seriesMap); 
  }

  Future<dynamic> deleteSerie(String nome) async {
    final Database db = await getDatabase();
    return await db.delete('series', where: 'nome = "$nome"');
  }

  List<Series> toList(List<Map<String, dynamic>> result){
    final List<Series> seriesList = [];
    for (Map<String, dynamic> row in result) {
      final Series serie = Series();
      serie.nome = row['nome'];
      serie.imagemUrl = row['imagemUrl'];
      serie.descricao = row['descricao'];
      serie.avaliacao = row['avaliacao'];
      seriesList.add(serie);
    }
    return seriesList;
  }

  Map<String, dynamic> toMap (Series serie){
    final Map<String, dynamic> serieMap = {};
    serieMap['nome'] = serie.nome;
    serieMap['imagemUrl'] = serie.imagemUrl;
    serieMap['descricao'] = serie.descricao;
    serieMap['avaliacao'] = serie.avaliacao;
    return serieMap;
  }
}