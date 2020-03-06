import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mercado_inteligente/br/com/mercadoInteligente/data/models/Empresa.dart';

class EmpresaRemote{

  Future<String> enviar(Empresa empresa) async {
    String json = jsonEncode(empresa.toMap());
    print("cotar");
   // var url ='http://192.168.43.20:8082/teste/empresaIn';
    var url ='http://192.168.0.15:8082/teste/empresaIn';
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': 'bearer  ${await tokenClient.getToken()}'
        },
        body: jsonEncode(empresa.toMap()));
        return  response.statusCode.toString();

  }
}