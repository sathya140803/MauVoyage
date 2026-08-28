import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_application/Applocalizations.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double _convertedAmount = 0.0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'MUR';
  bool _isLoading = false;
  String _errorMessage = '';
  final List<String> _currencies = ['USD', 'MUR', 'EUR', 'JPY'];
  double _conversionRate = 0.0;

  // Fallback rates for when API fails
  final Map<String, Map<String, double>> _fallbackRates = {
    'USD': {'MUR': 45.0, 'EUR': 0.93, 'JPY': 150.0, 'USD': 1.0},
    'EUR': {'USD': 1.07, 'MUR': 48.0, 'JPY': 160.0, 'EUR': 1.0},
    'MUR': {'USD': 0.022, 'EUR': 0.021, 'JPY': 3.33, 'MUR': 1.0},
    'JPY': {'USD': 0.0067, 'EUR': 0.0063, 'MUR': 0.30, 'JPY': 1.0},
  };

  @override
  void initState() {
    super.initState();
    // Initialize with fallback rate first
    _setFallbackRate();
    // Then try to fetch real rate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchConversionRate();
    });
  }

  void _setFallbackRate() {
    if (_fallbackRates.containsKey(_fromCurrency) &&
        _fallbackRates[_fromCurrency]!.containsKey(_toCurrency)) {
      setState(() {
        _conversionRate = _fallbackRates[_fromCurrency]![_toCurrency]!;
      });
    }
  }

  Future<void> _fetchConversionRate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Try first API
      final url = 'https://api.exchangerate.host/latest?base=$_fromCurrency';
      print('Fetching exchange rates from: $url');

      final response = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['rates'] != null && data['rates'][_toCurrency] != null) {
          setState(() {
            _conversionRate = data['rates'][_toCurrency].toDouble();
            _isLoading = false;
          });
          return;
        }

        // Try alternative API if first one failed
        _tryAlternativeApi();
      } else {
        _tryAlternativeApi();
      }
    } catch (e) {
      print('Error fetching conversion rate: $e');
      _tryAlternativeApi();
    }
  }

  Future<void> _tryAlternativeApi() async {
    try {
      // Alternative API
      final url = 'https://open.er-api.com/v6/latest/$_fromCurrency';
      print('Fetching from alternative API: $url');

      final response = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['rates'] != null && data['rates'][_toCurrency] != null) {
          setState(() {
            _conversionRate = data['rates'][_toCurrency].toDouble();
            _isLoading = false;
          });
          return;
        }
      }

      // Use fallback if both APIs fail
      _useFallbackRates();
    } catch (e) {
      print('Error with alternative API: $e');
      _useFallbackRates();
    }
  }

  void _useFallbackRates() {
    _setFallbackRate();
    setState(() {
      _isLoading = false;
      _errorMessage = 'Using offline rates';
    });
  }

  void _convertCurrency() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _convertedAmount = 0.0;
      });
      return;
    }

    try {
      double amount = double.parse(_amountController.text);
      setState(() {
        _convertedAmount = amount * _conversionRate;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid amount';
      });
    }
  }

  String _getTranslation(String key, String defaultValue) {
    try {
      final appLocalizations = AppLocalizations.of(context);
      if (appLocalizations != null) {
        return appLocalizations.translate(key);
      }
    } catch (e) {
      // Fallback if translation fails
    }
    return defaultValue;
  }

  void _onKeyPressed(String value) {
    String enterText = _getTranslation("enter", "Enter");

    setState(() {
      if (value == 'C') {
        _amountController.clear();
      } else if (value == enterText || value == "प्रवेश करें") {
        _convertCurrency();
      } else {
        _amountController.text += value;
      }
    });
  }

  Widget _buildNumericKeypad() {
    // Safely get the translation
    String enterText = _getTranslation("enter", "Enter");

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
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
          'C', '0', enterText
        ];
        String buttonText = buttons[index];

        return ElevatedButton(
          onPressed: () => _onKeyPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.white,
            foregroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(buttonText),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTranslation("currency_converter", "Currency Converter")),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.orange[800], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _fromCurrency,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _fromCurrency = newValue;
                              _setFallbackRate(); // Apply fallback rate immediately
                              _fetchConversionRate(); // Then try to get actual rate
                            });
                          }
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_downward, color: Colors.white, size: 24),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _toCurrency,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _toCurrency = newValue;
                              _setFallbackRate(); // Apply fallback rate immediately
                              _fetchConversionRate(); // Then try to get actual rate
                            });
                          }
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
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
                        '$_toCurrency: ${_convertedAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
    _focusNode.dispose();
    super.dispose();
  }
}