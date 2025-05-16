class WeatherData {
  final String name;
  final Temperature temperature;
  final int humidity;
  final Wind wind;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int seaLevel;
  final List<WeatherInfo> weather;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    return WeatherData(
      name: json['name'],
      temperature: Temperature.fromKelvin(main['temp']),
      humidity: main['humidity'],
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (main['temp_max'] - 273.15),
      minTemperature: (main['temp_min'] - 273.15),
      pressure: main['pressure'],
      seaLevel: main['sea_level'] ?? 0,
      weather: (json['weather'] as List)
          .map((w) => WeatherInfo.fromJson(w))
          .toList(),
    );
  }
}

class WeatherInfo {
  final String main;

  WeatherInfo({required this.main});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(main: json['main']);
  }
}

class Temperature {
  final double current;

  Temperature({required this.current});

  factory Temperature.fromKelvin(double kelvin) {
    return Temperature(current: kelvin - 273.15);
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: (json['speed'] as num).toDouble());
  }
}
