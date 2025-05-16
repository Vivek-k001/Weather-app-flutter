import 'dart:convert';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  // Replace {lat}, {lon}, and {API_KEY} with actual values or parameters
  Future<WeatherData?> fetchWeather({
    required double lat,
    required double lon,
    required String apiKey,
  }) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }
}
