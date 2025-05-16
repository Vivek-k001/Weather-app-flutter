import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:flutter_application_1/services/services.dart';
import 'package:intl/intl.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  WeatherData? weatherInfo;
  bool isLoading = false;

  // Replace these with your actual latitude, longitude and API key
  final double latitude = 11.0189; // example: San Francisco lat
  final double longitude = -76.1760; // example: San Francisco lon
  final String apiKey = 'd3bb82e6846584ec26891c092a9f7b24';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() {
      isLoading = false;
    });
    final data = await WeatherServices().fetchWeather(
      lat: latitude,
      lon: longitude,
      apiKey: apiKey,
    );
    if (data != null) {
      setState(() {
        weatherInfo = data;
        isLoading = true;
      });
    } else {
      // Handle failure case if needed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: isLoading && weatherInfo != null
              ? WeatherDetail(
                  weather: weatherInfo!,
                  formattedDate: formattedDate,
                  formattedTime: formattedTime,
                )
              : const CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          weather.name,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}°C",
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 30),
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cloudy.png"),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherInfoCard(
                      icon: Icons.wind_power,
                      title: "Wind",
                      value: "${weather.wind.speed} km/h",
                    ),
                    weatherInfoCard(
                      icon: Icons.sunny,
                      title: "Max",
                      value: "${weather.maxTemperature.toStringAsFixed(2)}°C",
                    ),
                    weatherInfoCard(
                      icon: Icons.ac_unit,
                      title: "Min",
                      value: "${weather.minTemperature.toStringAsFixed(2)}°C",
                    ),
                  ],
                ),
                const Divider(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherInfoCard(
                      icon: Icons.water_drop,
                      title: "Humidity",
                      value: "${weather.humidity}%",
                    ),
                    weatherInfoCard(
                      icon: Icons.air,
                      title: "Pressure",
                      value: "${weather.pressure} hPa",
                    ),
                    weatherInfoCard(
                      icon: Icons.leaderboard,
                      title: "Sea-Level",
                      value: "${weather.seaLevel} m",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
