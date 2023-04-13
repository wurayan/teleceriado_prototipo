import 'package:flutter/material.dart';
import 'package:teleceriado/database/dao/series_dao.dart';
import 'package:teleceriado/screens/details_serie.dart';

import '../models/series.dart';
import 'add_serie.dart';

class FeedSeries extends StatefulWidget {
  const FeedSeries({super.key});

  @override
  State<FeedSeries> createState() => _FeedSeriesState();
}

class _FeedSeriesState extends State<FeedSeries> {
  final SeriesDao _dao = SeriesDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas séries'),
      ),
      body: FutureBuilder<List<Series>>(
        initialData: const [],
        future: _dao.findAllSeries(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const CircularProgressIndicator(
                value: null,
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Series> seriesList = snapshot.data as List<Series>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Series serie = seriesList[index];
                  return _SerieItem(serie: serie);
                },
                itemCount: seriesList.length,
              );
          }
          return const Center(
            child: Text('Algo deu errado na conexão'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSerie()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SerieItem extends StatelessWidget {
  final Series serie;
  const _SerieItem({super.key, required this.serie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.15,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailSerie(serie: serie,)));
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: width * 0.95,
            height: height * 0.15,
            decoration: BoxDecoration(
                color: Color.fromARGB(202, 255, 255, 255),
                boxShadow: const [
                   BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3)),
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                serie.imagemUrl != null
                    ? Image.network(
                        serie.imagemUrl!,
                        fit: BoxFit.cover,
                        width: width * 0.35,
                        height: double.infinity,
                      )
                    : SizedBox(
                        width: width * 0.035,
                        height: height * 0.15,
                      ),
                Expanded(
                  child: Padding(
                    padding:
                      EdgeInsets.only(top: height * 0.01, left: width * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            serie.nome!,
                            style: const TextStyle(fontSize: 20, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          height: height * 0.05,
                          // width: width*0.5,
                          color: Colors.green,
                          child: const Text(
                            'AQUI VAI A AVALIAÇÃO',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // const Expanded(child: SizedBox()),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.01),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_document,
                        size: width * 0.1,
                        color: Colors.black54,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
