import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/cep.dart';

Future<Cep> searchZipCode(String cep) async {
  var url = setUrl(cep);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print(''' 

    OPA! ENCONTREI AQUI 

    CEP: ${jsonResponse['cep']}
    ESTADO: ${jsonResponse['state']}
    CIDADE: ${jsonResponse['city']}
    BAIRRO: ${jsonResponse['neighborhood']}
    RUA: ${jsonResponse['street']}
    LONGITUDE: ${jsonResponse['location']['coordinates']['longitude']}
    LATITUDE: ${jsonResponse['location']['coordinates']['latitude']}
    PROVEDOR: ${jsonResponse['service']}
    ''');

    Cep auxCep = Cep(
        id: jsonResponse['cep'],
        state: jsonResponse['state'],
        city: jsonResponse['city'],
        neighborhood: jsonResponse['neighborhood'],
        street: jsonResponse['street'],
        long: jsonResponse['location']['coordinates']['longitude'],
        lat: jsonResponse['location']['coordinates']['latitude'],
        service: jsonResponse['service']);

    return auxCep;
  } else {
    return Cep(
        id: '',
        state: '',
        city: '',
        neighborhood: '',
        street: '',
        long: '',
        lat: '',
        service: '');
  }
  print("ACHEI NADA NÃO MANO");
}

setUrl(String cep) => Uri.parse('https://brasilapi.com.br/api/cep/v2/{$cep}');
