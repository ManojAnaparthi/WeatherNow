import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final String city;

  const WeatherPage({super.key, required this.city});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('4e6814a13a66a959baee5b483bbe74e7');
  Weather? _weather;
  bool _isLoading = true;
  bool _hasError = false;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(widget.city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  String getWeatherIcon(String? condition) {
    if (condition == null) return 'assets/sunny.json';
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Weather App", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green[200],
      body: _isLoading
          ? Center(child: Lottie.asset('assets/loader.json', width: 150))
          : _hasError
          ? Center(child: Text('Error fetching weather', style: TextStyle(fontSize: 20)))
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(_weather?.city_name ?? "", style: const TextStyle(fontSize: 30))),
          Lottie.asset(getWeatherIcon(_weather?.condition)),
          Center(child: Text('${_weather?.temperature.round()}°C', style: const TextStyle(fontSize: 22))),
          Center(child: Text(_weather?.condition ?? "", style: const TextStyle(fontSize: 28))),
          Center(child: Text('Humidity: ${_weather?.humidity}%', style: const TextStyle(fontSize: 20))),
          Center(child: Text('Wind Speed: ${_weather?.windSpeed} m/s', style: const TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
