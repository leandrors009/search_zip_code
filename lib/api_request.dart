import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

searchZipCode(cep) async {
  var url = setUrl(cep);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    return ''' 

    OPA! ENCONTREI AQUI 

    CEP: ${jsonResponse['cep']}
    ESTADO: ${jsonResponse['state']}
    CIDADE: ${jsonResponse['city']}
    BAIRRO: ${jsonResponse['neighborhood']}
    RUA: ${jsonResponse['street']}
    LONGITUDE: ${jsonResponse['location']['coordinates']['longitude']}
    LATITUDE: ${jsonResponse['location']['coordinates']['latitude']}
    PROVEDOR: ${jsonResponse['service']}


    ''';
  } else {
    return 'Error: ${response.statusCode}';
  }
}

setUrl(String cep) => Uri.parse('https://brasilapi.com.br/api/cep/v2/{$cep}');
