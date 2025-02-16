import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();  // FocusNode to manage focus
  double _convertedAmount = 0.0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'MUR';
  final List<String> _currencies = ['USD', 'MUR', 'EUR', 'JPY'];
  late double _conversionRate;

  @override
  void initState() {
    super.initState();
    _fetchConversionRate();
  }

  Future<void> _fetchConversionRate() async {
    final response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$_fromCurrency'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _conversionRate = data['rates'][_toCurrency] ?? 0.0;
      });
    } else {
      throw Exception('Failed to load conversion rate');
    }
  }

  void _convertCurrency() {
    setState(() {
      double amount = double.tryParse(_amountController.text) ?? 0.0;
      _convertedAmount = amount * _conversionRate;
    });
  }

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'C') {
        _amountController.clear();
      } else if (value == 'Enter') {
        _convertCurrency();
      } else {
        _amountController.text += value;
      }
    });
  }

  Widget _buildNumericKeypad() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5, // Larger buttons
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: 12,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        List<String> buttons = [
          '1', '2', '3',
          '4', '5', '6',
          '7', '8', '9',
          'C', '0', 'Enter'
        ];
        String buttonText = buttons[index];

        return ElevatedButton(
          onPressed: () => _onKeyPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20), // Larger padding for touch targets
            iconColor: buttonText == 'C'
                ? Colors.red // Clear button in red
                : buttonText == 'Enter'
                ? Colors.green // Enter button in green
                : Colors.blue, // Normal buttons in blue
            textStyle: const TextStyle(fontSize: 20), // Consistent font size
          ),
          child: Text(buttonText),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              // Title
              const Text(
                'Currency Converter',
                style: TextStyle(
                  fontSize: 32, // Slightly larger title
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Input and Dropdown
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromCurrency = newValue!;
                          _fetchConversionRate();
                        });
                      },
                      items: _currencies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Text field for amount input
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      focusNode: _focusNode,  // Attach the focus node
                      keyboardType: TextInputType.none,  // Disable default keyboard
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.red[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 185), // Add left padding to move arrows to the right
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_upward, color: Colors.white, size: 24),
                    SizedBox(width: 20),
                    Icon(Icons.arrow_downward, color: Colors.white, size: 24),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Output and Dropdown for destination currency
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _toCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toCurrency = newValue!;
                          _fetchConversionRate();
                        });
                      },
                      items: _currencies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_convertedAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Numeric Keypad
              Expanded(child: _buildNumericKeypad()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();  // Dispose of the focus node
    super.dispose();
  }
}
