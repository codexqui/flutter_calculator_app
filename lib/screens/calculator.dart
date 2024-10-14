import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _result = 0;
  int _number1 = 0;
  int _number2 = 0;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller1.text = _number1.toString();
    _controller2.text = _number2.toString();

    // Agregamos listeners para limpiar los campos cuando se hace foco en ellos
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus && _controller1.text == '0') {
        setState(() {
          _controller1.clear(); // Limpia el campo si tiene "0"
        });
      }
    });

    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus && _controller2.text == '0') {
        setState(() {
          _controller2.clear(); // Limpia el campo si tiene "0"
        });
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Minimalist Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildNumberInput(_controller1, _focusNode1, (value) => _number1 = value)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildNumberInput(_controller2, _focusNode2, (value) => _number2 = value)),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOperationButton('+'),
                  _buildOperationButton('–'), // Usar guion largo para una mejor visualización
                  _buildOperationButton('×'),
                  _buildOperationButton('÷'),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Result: $_result',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: Colors.white),
                ),
              ),
              const Spacer(),
              const Text(
                'Developed by: CodexQUI',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberInput(TextEditingController controller, FocusNode focusNode, Function(int) onChanged) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w300),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onChanged: (value) {
        setState(() {
          onChanged(int.tryParse(value) ?? 0);
        });
      },
      onEditingComplete: () {
        // Si el campo está vacío al perder foco, lo restauramos a "0"
        if (controller.text.isEmpty) {
          setState(() {
            controller.text = '0';
          });
        }
      },
    );
  }

  Widget _buildOperationButton(String operation) {
    return IconButton(
      onPressed: () => _operate(operation),
      icon: Text(
        operation,
        style: const TextStyle(fontSize: 36, color: Colors.white), // Aumenta el tamaño del texto
      ),
    );
  }

  void _operate(String operation) {
    setState(() {
      switch (operation) {
        case '+':
          _result = _number1 + _number2;
          break;
        case '–': // Usar guion largo aquí también
          _result = _number1 - _number2;
          break;
        case '×':
          _result = _number1 * _number2;
          break;
        case '÷':
          _result = _number2 != 0 ? _number1 ~/ _number2 : 0;
          break;
      }
    });
  }
}
