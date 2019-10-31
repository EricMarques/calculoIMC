import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Cálculo IMC",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados";

  void _resetField() {
    weightController.clear();
    heightController.clear();

    setState(() {
      _infoText = "Informe os dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      print(imc);
      if (imc < 18.5) {
        _infoText = "Abaixo do peso\nIMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText = "Peso Adequado\nIMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25 && imc < 29.9) {
        _infoText = "Sobrepeso\nIMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30 && imc < 34.9) {
        _infoText = "Obesidade Grau I\nIMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 35 && imc < 39.9) {
        _infoText = "Obesidade Grau II\nIMC: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III\nIMC: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetField();
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 130,
                color: Colors.green[300],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green[300],
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira o valor do Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green[300],
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira o valor da Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    color: Colors.green[200],
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
