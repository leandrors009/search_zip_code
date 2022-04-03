import 'package:flutter/material.dart';
import '../api_request.dart' as api;
import '../components/cardCep.dart';
import '../models/cep.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textFieldController = TextEditingController();
  late Cep cepResult;
  late bool ltemDados;

  @override
  void initState() {
    buscaCep('');
    setState(() {
      ltemDados = false;
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    dispose();
  }

  void buscaCep(String cepAux) {
    api.searchZipCode(cepAux).then(
      (value) {
        setState(() {
          cepResult = value;
        });
      },
    );
  }

  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
              child: Column(
                children: [
                  Padding(
                    // TEXTO DE BOAS VINDAS
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá,",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black45),
                              ),
                              Text("Leandro",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ]),
                  ),
                  Padding(
                    // TEXTO "DIGITE O CEP PARA PESQUISAR"
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Text(
                          'Digite o CEP para pesquisar:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    // BARRA DE PESQUISA
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: TextFormField(
                        controller: textFieldController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(
                                left: 20, top: 15, right: 20, bottom: 15),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: CircleAvatar(
                                child: IconButton(
                                    icon: Icon(Icons.search),
                                    color: Colors.blueAccent[100],
                                    onPressed: () =>
                                        {buscaCep(textFieldController.text)}),
                                backgroundColor: Colors.blue[50],
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  cepResult.id.isNotEmpty
                      ? cardCep(cep: cepResult)
                      : Padding(
                          padding: EdgeInsets.all(50),
                          child: Text(
                            'CEP Inválido!',
                            style: TextStyle(color: Colors.red, fontSize: 30),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
