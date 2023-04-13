import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/database/dao/series_dao.dart';
import 'package:teleceriado/models/series.dart';

import 'components/header_field.dart';

class AddSerie extends StatelessWidget {
   AddSerie({super.key});

  final SeriesDao _dao = SeriesDao();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Série'),),
      body: Form(
        key: _formKey,
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderField(value: 'Nome da Série:',),
              TextFormField(
                controller: _nomeController,
                onTapOutside: (event)=>FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 18),
                validator: (value) =>
                  value==null||value.isEmpty?'Campo obrigatório!':null
                ,
              ),
              HeaderField(value: 'URL da imagem:',),
              TextFormField(
                controller: _imagemUrlController,
                onTapOutside: (event)=>FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.url,
                style: const TextStyle(fontSize: 18),
              ),
              HeaderField(value: 'AQUI VAI O WIDGET DE AVALIAÇÃO'),
              SizedBox(
                height: height*0.2,
                width: width*0.9,
                child: TextFormField(
                  controller: _descricaoController,
                  keyboardType: TextInputType.text,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  style: const TextStyle(fontSize: 18),
                  expands: true,
                  minLines: null,
                  maxLines: null,
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
                      Series serie = Provider.of<Series>(context, listen: false);
                      serie.nome = _nomeController.text;
                      serie.imagemUrl = _avaliacaoController.text;
                      serie.imagemUrl = _imagemUrlController.text;
                      serie.avaliacao = _avaliacaoController.text.isEmpty?0:int.parse(_avaliacaoController.text);
                      _dao.saveSerie(serie).then((value) => Navigator.pop(context));
                    }
                  }, child: const Text('Salvar')),
                ],
              )
            ],
          ),
        ))
    );
  }
}

