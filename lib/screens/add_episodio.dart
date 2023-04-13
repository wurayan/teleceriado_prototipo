
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/database/dao/episodios_dao.dart';
import 'package:teleceriado/models/episodios.dart';
import 'package:teleceriado/screens/components/header_field.dart';

class AddEpisodio extends StatelessWidget {
  final String idSerie;
  AddEpisodio({super.key, required this.idSerie});

  final EpisodiosDao _dao = EpisodiosDao();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Episódio'),),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderField(value: 'Número do episódio:'),
              TextFormField(
                controller: _idController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18),
                validator: (value) => value==null||value.isEmpty?'Campo obrigatório':null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              HeaderField(value: 'Nome do Epidódio'),
              TextFormField(
                controller: _nomeController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 18),
                maxLength: 50,
              ),
              HeaderField(value: 'URL da imagem:',),
              TextFormField(
                controller: _imagemUrlController,
                onTapOutside: (event)=>FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.url,
                style: const TextStyle(fontSize: 18),
              ),
              HeaderField(value: 'AQUI VAI O WIDGET DE AVALIAÇÃO'),
              HeaderField(value: 'Descrição do Episódio:'),
              SizedBox(
                height: height*0.15,
                width: width*0.9,
                child: TextFormField(
                  controller: _descricaoController,
                  keyboardType: TextInputType.text,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  style: const TextStyle(fontSize: 18),
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  maxLength: 144,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  }, child: const Text('Voltar')),
                  ElevatedButton(onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      Episodios episodio = Provider.of<Episodios>(context, listen: false);
                      episodio.id = int.parse(_idController.text);
                      episodio.idSerie = idSerie;
                      episodio.imagemUrl = _imagemUrlController.text;
                      episodio.nome = _nomeController.text;
                      episodio.descricao = _descricaoController.text;
                      _dao.saveEpisodio(idSerie, episodio).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  }, child: const Text('Salvar')),
                ],
              )
            ],
          ),
        )),
    );
  }
}