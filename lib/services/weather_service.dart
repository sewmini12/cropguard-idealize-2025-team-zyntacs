import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/app_models.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey =
      '4fe711c1a1ffd352471bb72500cecea6'; // Replace with actual OpenWeatherMap API key

  // Alternative free weather service (if you don't have OpenWeatherMap API key)
  static const String _freeWeatherUrl = 'https://api.open-meteo.com/v1';

  /// Get current location weather data
  static Future<WeatherData?> getCurrentLocationWeather() async {
    try {
      final position = await _getCurrentPosition();
      if (position != null) {
        return getCurrentWeatherByCoordinates(
            position.latitude, position.longitude);
      }
    } catch (e) {
      print('Error getting current location weather: $e');
    }
    return null;
  }

  /// Get current weather by coordinates
  static Future<WeatherData?> getCurrentWeatherByCoordinates(
      double lat, double lon) async {
    try {
      // Using OpenWeatherMap API (requires API key)
      if (_apiKey != '4fe711c1a1ffd352471bb72500cecea6') {
        final response = await http.get(
          Uri.parse(
              '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return WeatherData.fromJson(data);
        }
      } else {
        // Using free Open-Meteo API as fallback
        return _getCurrentWeatherFromOpenMeteo(lat, lon);
      }
    } catch (e) {
      print('Error fetching weather data by coordinates: $e');
    }
    return null;
  }

  /// Get current weather by city name
  static Future<WeatherData?> getCurrentWeatherByCity(String city) async {
    try {
      if (_apiKey != '4fe711c1a1ffd352471bb72500cecea6') {
        final response = await http.get(
          Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return WeatherData.fromJson(data);
        }
      } else {
        // Geocode city name to coordinates and use Open-Meteo
        final coordinates = await _geocodeCity(city);
        if (coordinates != null) {
          return _getCurrentWeatherFromOpenMeteo(
              coordinates['lat']!, coordinates['lon']!);
        }
      }
    } catch (e) {
      print('Error fetching weather data by city: $e');
    }
    return null;
  }

  /// Get 5-day forecast
  static Future<List<ForecastData>> getForecast(double lat, double lon) async {
    try {
      if (_apiKey != '4fe711c1a1ffd352471bb72500cecea6') {
        final response = await http.get(
          Uri.parse(
              '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> forecasts = data['list'];

          // Group by day and take one forecast per day
          final Map<String, Map<String, dynamic>> dailyForecasts = {};

          for (var forecast in forecasts) {
            final dateTime =
                DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
            final dateKey =
                '${dateTime.year}-${dateTime.month}-${dateTime.day}';

            if (!dailyForecasts.containsKey(dateKey)) {
              dailyForecasts[dateKey] = forecast;
            }
          }

          return dailyForecasts.values.take(5).map((forecast) {
            final dateTime =
                DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
            return ForecastData.fromJson(forecast, dateTime);
          }).toList();
        }
      } else {
        return _getForecastFromOpenMeteo(lat, lon);
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
    }
    return [];
  }

  /// Get UV Index
  static Future<int> getUVIndex(double lat, double lon) async {
    try {
      if (_apiKey != '4fe711c1a1ffd352471bb72500cecea6') {
        final response = await http.get(
          Uri.parse('$_baseUrl/uvi?lat=$lat&lon=$lon&appid=$_apiKey'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return data['value'].toInt();
        }
      }
    } catch (e) {
      print('Error fetching UV index: $e');
    }
    return 0;
  }

  /// Generate farming advice based on weather conditions
  static List<FarmingAdvice> generateFarmingAdvice(
      WeatherData weather, List<ForecastData> forecast) {
    List<FarmingAdvice> advice = [];

    // Temperature-based advice
    if (weather.temperature > 30) {
      advice.add(FarmingAdvice(
        title: 'Heat Stress Alert',
        content:
            'High temperatures detected. Increase watering frequency and provide shade for sensitive plants.',
        icon: 'thermometer',
        color: 'red',
        priority: 'high',
        category: 'temperature',
      ));
    } else if (weather.temperature < 5) {
      advice.add(FarmingAdvice(
        title: 'Frost Protection',
        content:
            'Low temperatures expected. Cover sensitive plants and bring potted plants indoors.',
        icon: 'ac_unit',
        color: 'blue',
        priority: 'high',
        category: 'temperature',
      ));
    }

    // Humidity-based advice
    if (weather.humidity > 80) {
      advice.add(FarmingAdvice(
        title: 'High Humidity Alert',
        content:
            'High humidity conditions favor fungal diseases. Improve air circulation and avoid overhead watering.',
        icon: 'water_drop',
        color: 'orange',
        priority: 'medium',
        category: 'humidity',
      ));
    }

    // Rain prediction advice
    final rainDays = forecast.where((f) => f.precipitation > 50).length;
    if (rainDays > 2) {
      advice.add(FarmingAdvice(
        title: 'Heavy Rain Expected',
        content:
            'Multiple rainy days ahead. Ensure proper drainage and delay fertilizer application.',
        icon: 'grain',
        color: 'blue',
        priority: 'high',
        category: 'precipitation',
      ));
    } else if (rainDays == 0 && forecast.isNotEmpty) {
      advice.add(FarmingAdvice(
        title: 'Dry Spell Ahead',
        content:
            'No rain expected in the forecast. Plan for increased irrigation and mulching.',
        icon: 'wb_sunny',
        color: 'orange',
        priority: 'medium',
        category: 'precipitation',
      ));
    }

    // UV Index advice
    if (weather.uvIndex > 7) {
      advice.add(FarmingAdvice(
        title: 'High UV Index',
        content:
            'Very high UV levels. Consider shade cloth for sensitive plants and work during cooler hours.',
        icon: 'wb_sunny',
        color: 'red',
        priority: 'medium',
        category: 'uv',
      ));
    }

    // Wind advice
    if (weather.windSpeed > 20) {
      advice.add(FarmingAdvice(
        title: 'Strong Winds',
        content:
            'Strong winds detected. Stake tall plants and delay spraying pesticides or fertilizers.',
        icon: 'air',
        color: 'orange',
        priority: 'medium',
        category: 'wind',
      ));
    }

    return advice;
  }

  // Private helper methods

  static Future<Position?> _getCurrentPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting current position: $e');
      return null;
    }
  }

  static Future<WeatherData?> _getCurrentWeatherFromOpenMeteo(
      double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_freeWeatherUrl/current?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final current = data['current'];

        return WeatherData(
          temperature: current['temperature_2m'].toDouble(),
          humidity: current['relative_humidity_2m'],
          windSpeed: current['wind_speed_10m'].toDouble(),
          condition: _getConditionFromWeatherCode(current['weather_code']),
          precipitation: 0,
          uvIndex: 0,
          location: 'Current Location',
          latitude: lat,
          longitude: lon,
        );
      }
    } catch (e) {
      print('Error fetching weather from Open-Meteo: $e');
    }
    return null;
  }

  static Future<List<ForecastData>> _getForecastFromOpenMeteo(
      double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_freeWeatherUrl/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,weather_code,precipitation_probability_max&forecast_days=5'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final daily = data['daily'];

        List<ForecastData> forecasts = [];
        for (int i = 0; i < 5; i++) {
          final date = DateTime.parse(daily['time'][i]);
          forecasts.add(ForecastData(
            day: ForecastData.formatDay(date),
            high: daily['temperature_2m_max'][i].toDouble(),
            low: daily['temperature_2m_min'][i].toDouble(),
            condition: _getConditionFromWeatherCode(daily['weather_code'][i]),
            precipitation: daily['precipitation_probability_max'][i].toInt(),
            icon: _getIconFromWeatherCode(daily['weather_code'][i]),
            date: date,
          ));
        }
        return forecasts;
      }
    } catch (e) {
      print('Error fetching forecast from Open-Meteo: $e');
    }
    return [];
  }

  static Future<Map<String, double>?> _geocodeCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0];
          return {
            'lat': result['latitude'].toDouble(),
            'lon': result['longitude'].toDouble(),
          };
        }
      }
    } catch (e) {
      print('Error geocoding city: $e');
    }
    return null;
  }

  static String _getConditionFromWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Clear';
      case 1:
      case 2:
      case 3:
        return 'Partly Cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }

  static String _getIconFromWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'wb_sunny';
      case 1:
      case 2:
      case 3:
        return 'wb_cloudy';
      case 45:
      case 48:
        return 'foggy';
      case 51:
      case 53:
      case 55:
        return 'grain';
      case 61:
      case 63:
      case 65:
        return 'grain';
      case 71:
      case 73:
      case 75:
        return 'ac_unit';
      case 95:
      case 96:
      case 99:
        return 'thunderstorm';
      default:
        return 'help';
    }
  }
}
