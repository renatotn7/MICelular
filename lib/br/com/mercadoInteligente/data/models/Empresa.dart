import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// cnpj : "4332423423"
/// razaoSocial : "teste da razao1"
/// ie : "2324324"
/// rua : "rua da criatividade"
/// numero : "1"
/// complemento : "blocob"
/// bairro : "rio comprido"
/// municipio : "rio de janeiro"
/// uf : "rj"
@JsonSerializable()
class Empresa {

  String cnpj;
  String razaoSocial;
  String ie;
  String rua;
  String numero;
  String complemento;
  String bairro;
  String municipio;
  String uf;

  String get gcnpj => cnpj;
  String get grazaoSocial => razaoSocial;
  String get gie => ie;
  String get grua => rua;
  String get gnumero => numero;
  String get gcomplemento => complemento;
  String get gbairro => bairro;
  String get gmunicipio => municipio;
  String get guf => uf;

  Empresa({this.cnpj, this.razaoSocial, this.ie, this.rua, this.numero, this.complemento, this.bairro, this.municipio, this.uf});

  Empresa.map(dynamic obj) {
    this.cnpj = obj["cnpj"];
    this.razaoSocial = obj["razaoSocial"];
    this.ie = obj["ie"];
    this.rua = obj["rua"];
    this.numero = obj["numero"];
    this.complemento = obj["complemento"];
    this.bairro = obj["bairro"];
    this.municipio = obj["municipio"];
    this.uf = obj["uf"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["cnpj"] = cnpj;
    map["razaoSocial"] = razaoSocial;
    map["ie"] = ie;
    map["rua"] = rua;
    map["numero"] = numero;
    map["complemento"] = complemento;
    map["bairro"] = bairro;
    map["municipio"] = municipio;
    map["uf"] = uf;
    return map;
  }

}