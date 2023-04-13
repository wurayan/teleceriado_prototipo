import 'package:flutter/material.dart';

class Series extends ChangeNotifier {
  String? _nome;
  String? _imagemUrl;
  String? _descricao;
  int? _avaliacao;

  String? get nome => _nome;
  String? get imagemUrl => _imagemUrl;
  String? get descricao => _descricao;
  int? get avaliacao => _avaliacao;

  set nome(String? value) {
    _nome = value;
  }

  set imagemUrl(String? value) {
    _imagemUrl = value;
  }

  set descricao(String? value) {
    _descricao = value;
  }

  set avaliacao(int? value) {
    _avaliacao = value;
  }
}
