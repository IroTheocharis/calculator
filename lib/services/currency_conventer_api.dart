import 'package:calculator/models/currency_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyAPI {
  String urlBase = "https://api.fxratesapi.com";
  Map<String, double> _ratesCache = {};

  // Fetches the list of currencies from the API
  Future<List<Currency>> fetchCurrencies() async {
    final url = Uri.parse("$urlBase/currencies");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<Currency> currencies = [];
      jsonResponse.forEach((code, data) {
        currencies.add(Currency.fromJson(code, data));
      });
      return currencies;
    } else {
      throw Exception('Failed to load currencies list');
    }
  }

  // Function to fetch and cache rates for the specified base currency
  Future<void> fetchAndCacheRates(String baseCurrency) async {
    final url = Uri.parse('$urlBase/latest?base=$baseCurrency&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      Map<String, dynamic> rates = jsonResponse['rates'];

      _ratesCache = rates.map(
          (key, value) => MapEntry(key, value.toDouble())); // Update the cache
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  // Function to get a conversion rate from the cache
  double getConversionRate(String toCurrency) {
    return _ratesCache[toCurrency] ??
        0.0; // Return 0.0 or a default value if not found
  }
}
