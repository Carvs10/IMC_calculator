import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String infoText = "Tell me your Stats";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Tell me your Stats";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double IMC = weight / (height * height);

      if (IMC < 18.6) {
        infoText = "UnderWeight (${IMC.toStringAsPrecision(2)})";
      } else if (18.6 <= IMC && IMC < 24.9) {
        infoText = " Ideal Weight (${IMC.toStringAsPrecision(2)})";
      } else if (24.9 <= IMC && IMC < 29.9) {
        infoText = "A little OverWeight (${IMC.toStringAsPrecision(2)})";
      } else if (29.9 <= IMC && IMC < 34.9) {
        infoText = "Obesity I (${IMC.toStringAsPrecision(2)})";
      } else if (34.0 <= IMC && IMC < 39.9) {
        infoText = "Obesity II (${IMC.toStringAsPrecision(2)})";
      } else if (IMC >= 40.0) {
        infoText = "Obesity III (${IMC.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        leading: const Icon(Icons.mail),
        title: const Text('IMC - Calculator'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _resetField, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelStyle: TextStyle(color: Colors.green),
                      label: Text('Type your Weight (Kg)'),
                      border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insert your Weight";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelStyle: TextStyle(color: Colors.green),
                      label: Text('Type your Height (cm)'),
                      border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insert your height";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: const Text(
                        'Calculate',
                        style: TextStyle(fontSize: 21),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.green[600])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 21),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
