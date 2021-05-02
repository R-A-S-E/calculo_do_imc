import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

//classe para modificar o estado do objeto
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controller para captar oq está escrito no formulario
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  //controle de formulario como: não deixar vazio,ser só numero, ser só letra
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //para modificar o texto informado
  String _infoText = "Informe seus dados!";
  //void para resetar o aplivativo
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    //para modificar o texto no reset
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  //parametro para calcular e modificar o texto
  void _calculate() {
    //para mostrar os resultados quando calcular
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //scaffold para implementar botões|barra|formulario...
    return Scaffold(
        //barra de tarefa
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            //icone de reset
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        //parte do fundo definindo cor
        backgroundColor: Colors.red[75],
        //widget para rolagem da tela, com padding para tirar botões e formularios da borda
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            //form para possibilidade de adicionar um controle do formulario
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline,
                      size: 120.0, color: Colors.red[200]),
                  //formulario 1
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.red[200])),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red[200], fontSize: 25.0),
                    controller: weightController,
                    //validar se o formulario está em branco
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  //formulario 2
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: Colors.red[200])),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[200], fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      }),
                  //espaçamento do botão do formulario e da informação
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      //botão para calcular o IMC
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child:
                              Text("Calcular", style: TextStyle(fontSize: 35)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          )),
                    ),
                  ),
                  // texto informativo
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 25.0))
                ],
              ),
            )));
  }
}
