import 'package:flutter/material.dart';

class Conversor extends StatefulWidget {
  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.monetization_on),
          SizedBox(
            width: 20,
          ),
          Text('Conversor de Moedas'),
        ],
      ),
    );

    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final avaliableWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green[100],
          width: double.infinity,
          height: avaliableHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png',
                  width: avaliableHeight / 4, height: avaliableHeight / 4),
              Container(
                  margin: EdgeInsets.only(top: 50, bottom: 10),
                  width: avaliableWidth / 2,
                  child: TextField(
                    onChanged: (s) {
                      setState(() {
                        if (s != '') {
                          final a = double.parse(s);
                          _controller2.text = (a / 5.01).toStringAsFixed(2);
                          _controller3.text = (a / 5.98).toStringAsFixed(2);

                        } else {
                          _controller2.text = '';
                          _controller3.text = '';
                        }
                      });
                    },
                    controller: _controller,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Real (R\$)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green, width: 3),
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: avaliableWidth / 2,
                  child: TextField(
                    controller: _controller2,
                    onChanged: (s) {
                      setState(() {
                        if (s != '') {
                          final a = double.parse(s.replaceAll(',', '.'));
                          _controller.text = (a / 5.01).toStringAsFixed(2);
                          _controller3.text = (a / 1.19).toStringAsFixed(2);

                        } else {
                          _controller.text = '';
                          _controller3.text = '';
                        }
                      });
                    },
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Dólar (\$)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green, width: 3),
                      ),
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                  ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: avaliableWidth / 2,
                  child: TextField(
                    controller: _controller3,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Euro (€)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green, width: 3),
                      ),
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
