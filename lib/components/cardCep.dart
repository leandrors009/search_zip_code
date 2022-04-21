import 'package:flutter/material.dart';
import 'package:search_zip_code/components/dadosWidget.dart';

import '../models/cep.dart';

class cardCep extends StatelessWidget {
  final Cep cep;

  const cardCep({
    Key? key,
    required this.cep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // CONTAINER QUE MOSTRA OS DADOS CONSULTADOS
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height / 1.5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      dadosWidget(title: 'CEP', content: this.cep.id),
                      dadosWidget(title: 'ESTADO', content: this.cep.state),
                      dadosWidget(title: 'CIDADE', content: this.cep.city),
                      dadosWidget(title: 'RUA', content: this.cep.street),
                      dadosWidget(
                          title: 'BAIRRO', content: this.cep.neighborhood),
                      dadosWidget(title: 'LONGITUDE', content: this.cep.long),
                      dadosWidget(title: 'LATITUDE', content: this.cep.lat),
                    ],
                  ),
                )
              ], //AQUI ACABA O COLUMN QUE CONTÉM TODOS OS DADOS
            ),
          ),
        ),
      ),
    );
  }
}
