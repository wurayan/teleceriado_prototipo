import 'package:flutter/material.dart';

class Episodios extends ChangeNotifier {
  int? _id;
  String? _idSerie;
  String? _nome;
  String? _descricao;
  String? _imagemUrl;

  int? get id => _id;
  String? get idSerie => _idSerie;
  String? get nome => _nome;
  String? get descricao => _descricao;
  String? get imagemUrl => _imagemUrl;

  set id(int? value) => _id = value;
  set idSerie(String? value) => _idSerie = value;
  set nome(String? value) => _nome = value;
  set descricao(String? value) => _descricao = value;
  set imagemUrl(String? value) => _imagemUrl = value;
}
