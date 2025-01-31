import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '86f030ce3ac6fe3f761e67e535cdff89';

  // Fetch weather data for now and the following days
  static Future<Map<String, dynamic>> fetchWeatherForecast(String city) async {
    try {
      final apiUrl =
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$_apiKey';

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        // Current weather from the first entry
        final currentWeather = weatherData['list'][0];
        final temp = currentWeather['main']['temp'];
        final description = currentWeather['weather'][0]['description'];
        final iconCode = currentWeather['weather'][0]['icon'];

        // Multi-day forecast (every 8th entry represents the next day)
        final forecast = weatherData['list'].where((entry) {
          final entryTime = DateTime.parse(entry['dt_txt']);
          return entryTime.hour == 12; // Midday forecast for each day
        }).toList();

        return {
          'current': {
            'temp': temp,
            'description': description,
            'icon': iconCode,
          },
          'forecast': forecast,
        };
      } else {
        return {'error': 'Failed to load weather.'};
      }
    } catch (e) {
      return {'error': 'Error loading weather.'};
    }
  }

  // Helper method to convert the forecast data into a format usable by the UI
  static List<Map<String, String>> getFormattedForecast(List forecast) {
    return forecast.map((entry) {
      final date = DateTime.parse(entry['dt_txt']);
      final temp = entry['main']['temp'].toString();
      final icon = entry['weather'][0]['icon'];
      return {
        'date': '${date.month}/${date.day}',
        'temp': '$temp°C',
        'icon': 'https://openweathermap.org/img/wn/$icon@2x.png'
      };
    }).toList();
  }
}
