import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _result = 0;
  int _number1 = 0;
  int _number2 = 0;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller1.text = _number1.toString();
    _controller2.text = _number2.toString();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 65, 65, 65),
        centerTitle: true,
        title: const Text(
          'Flutter Calculator App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 10, 10, 10), // Fondo de color oscuro
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildNumberInput(_controller1, (value) => _number1 = value)),
                const SizedBox(width: 16),
                Expanded(child: _buildNumberInput(_controller2, (value) => _number2 = value)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperationButton('+', Icons.add),
                _buildOperationButton('-', Icons.remove),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperationButton('*', Icons.close),
                _buildOperationButton('/', Icons.auto_fix_off),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Spacer(),
            const Text(
              'Desarrollo en proceso por: CodexQUI',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberInput(TextEditingController controller, Function(int) onChanged) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 45, color: Colors.white),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 65, 65, 65),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onChanged: (value) {
        setState(() {
          onChanged(int.tryParse(value) ?? 0);
        });
      },
    );
  }

  Widget _buildOperationButton(String operation, IconData icon) {
    return ElevatedButton(
      onPressed: () => _operate(operation),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 117, 10, 117),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Icon(icon, size: 40, color: Colors.white),
    );
  }

  void _operate(String operation) {
    setState(() {
      switch (operation) {
        case '+':
          _result = _number1 + _number2;
          break;
        case '-':
          _result = _number1 - _number2;
          break;
        case '*':
          _result = _number1 * _number2;
          break;
        case '/':
          _result = _number2 != 0 ? _number1 ~/ _number2 : 0;
          break;
      }
    });
  }
}
