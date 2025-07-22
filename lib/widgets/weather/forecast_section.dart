import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class ForecastSection extends StatelessWidget {
  final List<ForecastData> forecast;

  const ForecastSection({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '5-Day Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final day = forecast[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.day,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          _getIconFromString(day.icon),
                          size: 28,
                          color: _getIconColor(day.condition),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${day.high.toInt()}°',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${day.low.toInt()}°',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              size: 10,
                              color: Colors.blue[400],
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${day.precipitation}%',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconFromString(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'wb_cloudy':
        return Icons.wb_cloudy;
      case 'cloud':
        return Icons.cloud;
      case 'grain':
        return Icons.grain;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.thunderstorm;
      case 'foggy':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getIconColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return Colors.orange;
      case 'rainy':
      case 'rain':
      case 'drizzle':
        return Colors.blue;
      case 'snow':
        return Colors.lightBlue;
      case 'thunderstorm':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
