// ignore_for_file: deprecated_member_use

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
  final _textNome = TextEditingController();
  bool lExibeCard = false;
  bool lExibeErro = false;
  String? valueText;
  String? codeDialog;

  Cep cepResult = Cep(
      id: '',
      state: '',
      city: '',
      neighborhood: '',
      street: '',
      long: '',
      lat: '',
      service: '');

  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      buscaCep('');
      lExibeCard = false;
      lExibeErro = false;
      errorMessage = '';
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    dispose();
  }

  Future<void> buscaCep(String cepAux) async {
    setState(() {
      lExibeCard = false;
      lExibeErro = false;
    });
    try {
      final Cep cepTosco = await api.searchZipCode(cepAux);
      setState(() {
        cepResult = cepTosco;
        errorMessage = '';
        lExibeCard = true;
        lExibeErro = false;
      });
    } catch (e) {
      setState(() {
        lExibeCard = false;
        if (cepAux.isEmpty) {
          lExibeErro = false;
          errorMessage = "";
        } else {
          lExibeErro = true;
          errorMessage = "$e";
        }

        cepResult = Cep(
            id: '',
            state: '',
            city: '',
            neighborhood: '',
            street: '',
            long: '',
            lat: '',
            service: '');
      });
    }
  }

  FocusNode myFocusNode = FocusNode();

  Future<void> displayInsertName(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insira seu primeiro nome:'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textNome,
              decoration: InputDecoration(hintText: "Ex: João"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

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
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 20),
              child: Column(
                children: [
                  Padding(
                    // TEXTO DE BOAS VINDAS
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: const [
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
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: TextFormField(
                        controller: textFieldController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20, bottom: 15),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: CircleAvatar(
                                child: IconButton(
                                    icon: const Icon(Icons.search),
                                    color: Colors.blueAccent[100],
                                    onPressed: () {
                                      buscaCep(textFieldController.text);
                                    }),
                                backgroundColor: Colors.blue[50],
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  if (lExibeCard) cardCep(cep: cepResult),
                  if (lExibeErro)
                    Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        errorMessage,
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
