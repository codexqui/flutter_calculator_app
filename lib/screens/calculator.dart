import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int result = 0;
  int number1 = 0;
  int number2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Calculadora',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: number1.toString()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 45),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          number1 = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: number2.toString()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 45),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          number2 = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 40,
                onPressed: () => operar('+'),
                icon: const Icon(Icons.add, size: 70),
              ),
              IconButton(
                iconSize: 40,
                onPressed: () => operar('-'),
                icon: const Icon(Icons.remove, size: 70),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 70,
                onPressed: () => operar('*'),
                icon: const Icon(Icons.close, size: 70),
              ),
              IconButton(
                iconSize: 70,
                onPressed: () => operar('/'),
                icon: const Icon(Icons.auto_fix_off, size: 70),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Resultado: $result',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  void operar(String operando) {
    setState(() {
      switch (operando) {
        case '+':
          result = number1 + number2;
        case '-':
          result = number1 - number2;
        case '*':
          result = number1 * number2;
        case '/':
          result = number1 ~/ number2;
      }
    });
  }
}
