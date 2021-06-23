import 'dart:ui';

import 'package:flutter/material.dart';

class Info extends StatelessWidget {

  final String dolar;
  final String euro;

  Info(this.dolar, this.euro);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      padding: EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 25,
              child: Text(
                'Valores de hoje:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              child: Card(
                color: Colors.green,
                elevation: 6,
                child: Center(
                  child: Text(
                    'Dólar R\$ $dolar', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              child: Card(
                color: Colors.green,
                elevation: 6,
                child: Center(
                  child: Text(
                    'Euro R\$ $euro', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
