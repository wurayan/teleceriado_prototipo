import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:teleceriado/database/dao/episodios_dao.dart';
import 'package:teleceriado/models/series.dart';

import '../models/episodios.dart';
import 'add_episodio.dart';

class DetailSerie extends StatefulWidget {
  final Series serie;
  const DetailSerie({super.key, required this.serie});

  @override
  State<DetailSerie> createState() => _DetailSerieState();
}

class _DetailSerieState extends State<DetailSerie> {
  final EpisodiosDao _dao = EpisodiosDao();
  List<Episodios> episodiosList = [];
  int episodiosListLenght = 0;
  Series? serie;

  updateList() {
    _dao.findAllEpisodios(serie!.nome!).then((value) {
      episodiosList = value;
      episodiosListLenght = value.length;
      setState(() {});
    });
  }

  @override
  void initState() {
    serie = widget.serie;
    _dao.findAllEpisodios(widget.serie.nome!).then((value) {
      episodiosList = value;
      episodiosListLenght = value.length;
      print(value);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //TODO REMOVER O SCAFFOLD E COLOCAR UM STACK, ASSIM PODEMOS COLOCAR ICONES EM CIMA DA IMAGEM (VOLTAR E EDITAR)
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: serie!.imagemUrl != null
                                  ? Image.network(
                                      serie!.imagemUrl!,
                                      width: width,
                                      height: height * 0.25,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(
                                      width: width,
                                      height: height * 0.25,
                                    )),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Text(
                            widget.serie.nome!,
                            style: const TextStyle(fontSize: 24),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: Center(
                            child: SizedBox(
                              width: width * 0.9,
                              height: height * 0.15,
                              child: widget.serie.descricao != null &&
                                      widget.serie.descricao!.isNotEmpty
                                  ? Text(widget.serie.descricao!,
                                      style: TextStyle(fontSize: 16))
                                  : const Text('Ainda sem descrição...',
                                      style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const Text(
                          'AQUI VAI A AVALIAÇÃO',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _EpisodioItem(
                      episodio: episodiosList[index],
                      serieImagem: serie!.imagemUrl ?? '',
                    );
                  },
                  childCount: episodiosListLenght,
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01, right: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                      )),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 40,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEpisodio(idSerie: serie!.nome!)))
              .then((value) {
            updateList();
          });
        },
        child: const Icon(Icons.add_rounded, weight: 800, size: 50,),
      ),
    );
  }
}

class _EpisodioItem extends StatelessWidget {
  final String serieImagem;
  final Episodios episodio;
  const _EpisodioItem(
      {super.key, required this.episodio, required this.serieImagem});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        // color: Colors.purple,
        width: width,
        height: height * 0.15,
        child: Row(
          children: [
            episodio.imagemUrl != null
                ? Image.network(
                    episodio.imagemUrl!,
                    width: width * 0.3,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: width * 0.3,
                    height: double.infinity,
                  ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, top: height * 0.013),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Text(
                      '${episodio.id}. ${episodio.nome!}',
                      style: const TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.008),
                    child: SizedBox(
                      height: height * 0.06,
                      width: width * 0.65,
                      child: Text(
                        episodio.descricao != null ||
                                episodio.descricao!.isNotEmpty
                            ? episodio.descricao!
                            : 'Sem descrição',
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(top: height*0.01, bottom: height*0.03),
            //       child: ClipRRect(
            //         borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            //         child: serie.imagemUrl!=null?Image.network(serie.imagemUrl!,
            //         width: width, height: height*0.25, fit: BoxFit.cover,):SizedBox(width: width,height: height*0.25,)
            //       ),
            //     ),
            //     Padding(
            //       padding:  EdgeInsets.symmetric(horizontal: width*0.05),
            //       child: Text(serie.nome!, style: const TextStyle(fontSize: 24),
            //       maxLines: 2,
            //       overflow: TextOverflow.ellipsis,),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: height*0.01),
            //       child: Center(
            //         child: SizedBox(
            //           width: width*0.9,
            //           height: height*0.2,
            //           child: serie.descricao!=null&&serie.descricao!.isNotEmpty? Text(serie.descricao!,
            //           style: TextStyle(fontSize: 16)):const Text('Ainda sem descrição...',
            //           style: TextStyle(fontSize: 16)),
            //         ),
            //       ),
            //     ),
            //     const Divider(
            //       thickness: 2,
            //       color: Colors.black,
            //     ),
            //     const Text('AQUI VAI A AVALIAÇÃO', style: TextStyle(fontSize: 20),)
            //   ],
            // ),