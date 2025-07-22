import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherData weather;

  const CurrentWeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    weather.location,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather.temperature.toInt()}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        weather.condition,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      if (weather.description != null)
                        Text(
                          weather.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  _getWeatherIcon(weather.condition),
                  size: 80,
                  color: Colors.white70,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail(
                  'Humidity',
                  '${weather.humidity}%',
                  Icons.water_drop,
                ),
                _buildWeatherDetail(
                  'Wind',
                  '${weather.windSpeed.toInt()} km/h',
                  Icons.air,
                ),
                _buildWeatherDetail(
                  'UV Index',
                  '${weather.uvIndex}',
                  Icons.wb_sunny,
                ),
              ],
            ),
            if (weather.tempMin != null && weather.tempMax != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High: ${weather.tempMax!.toInt()}°C',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Low: ${weather.tempMin!.toInt()}°C',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return Icons.wb_sunny;
      case 'partly cloudy':
      case 'partly_cloudy':
        return Icons.wb_cloudy;
      case 'cloudy':
      case 'overcast':
        return Icons.cloud;
      case 'rain':
      case 'rainy':
      case 'drizzle':
        return Icons.grain;
      case 'snow':
      case 'snowy':
        return Icons.ac_unit;
      case 'thunderstorm':
      case 'storm':
        return Icons.thunderstorm;
      case 'fog':
      case 'foggy':
      case 'mist':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }
}
