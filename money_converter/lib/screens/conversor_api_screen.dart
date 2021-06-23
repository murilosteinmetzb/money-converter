import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:money_converter/screens/info_screen.dart';

String request = "https://api.hgbrasil.com/finance?format=json&key=5d43d845";

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class ConversorApi extends StatefulWidget {
  @override
  _ConversorApiState createState() => _ConversorApiState();
}

class _ConversorApiState extends State<ConversorApi> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double? dolar;
  double? euro;

  void _openModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Info(dolar.toString(), euro.toString());
        });
  }
  

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _openModal(context);
              },
              icon: Icon(Icons.info)),
          IconButton(
              onPressed: () {
                dolarController.text = '';
                euroController.text = '';
                realController.text = '';
              },
              icon: Icon(Icons.restore))
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.monetization_on),
            Text('Conversor de Moedas'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando...",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar...",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = (snapshot.data as dynamic)["results"]["currencies"]
                    ["USD"]["buy"];
                euro = (snapshot.data as dynamic)["results"]["currencies"]
                    ["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset('assets/images/logo.png',
                            width: 150, height: 150),
                        SizedBox(
                          height: 60,
                        ),
                        buildTextField(
                            "Real", "R\$", realController, _realChanged),
                        SizedBox(
                          height: 30,
                        ),
                        buildTextField(
                            "Dólar", "US\$", dolarController, _dolarChanged),
                        SizedBox(
                          height: 30,
                        ),
                        buildTextField(
                            "Euro", "€", euroController, _euroChanged),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    onChanged: (s) {
      f(s);
    },
    keyboardType: TextInputType.number,
    style: TextStyle(fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      hintText: '$label ($prefix)',
      labelText: '$label ($prefix)',
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.green, width: 3),
      ),
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}
