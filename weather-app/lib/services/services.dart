
import 'dart:convert';

import 'package:flutter_application_1/model/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherServices {
  fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}"),
    );
    // now we can cange latitude and longitude and let's see how it perfrom.
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
// replace the api key with your api key thay openWeathemap provide you
// for your current location provide the longitude and latitude of your current location