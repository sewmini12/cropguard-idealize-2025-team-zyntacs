import 'package:flutter/material.dart';

class WeatherAdviceScreen extends StatefulWidget {
  const WeatherAdviceScreen({super.key});

  @override
  State<WeatherAdviceScreen> createState() => _WeatherAdviceScreenState();
}

class _WeatherAdviceScreenState extends State<WeatherAdviceScreen> {
  final Map<String, dynamic> _currentWeather = {
    'temperature': 24,
    'humidity': 65,
    'windSpeed': 8,
    'condition': 'Partly Cloudy',
    'precipitation': 20,
    'uvIndex': 6,
    'location': 'San Francisco, CA',
  };

  final List<Map<String, dynamic>> _forecast = [
    {
      'day': 'Today',
      'high': 26,
      'low': 18,
      'condition': 'Partly Cloudy',
      'precipitation': 20,
      'icon': Icons.wb_cloudy,
    },
    {
      'day': 'Tomorrow',
      'high': 28,
      'low': 20,
      'condition': 'Sunny',
      'precipitation': 5,
      'icon': Icons.wb_sunny,
    },
    {
      'day': 'Wednesday',
      'high': 22,
      'low': 16,
      'condition': 'Rainy',
      'precipitation': 85,
      'icon': Icons.grain,
    },
    {
      'day': 'Thursday',
      'high': 25,
      'low': 19,
      'condition': 'Cloudy',
      'precipitation': 30,
      'icon': Icons.cloud,
    },
    {
      'day': 'Friday',
      'high': 29,
      'low': 22,
      'condition': 'Sunny',
      'precipitation': 0,
      'icon': Icons.wb_sunny,
    },
  ];

  final List<Map<String, dynamic>> _farmingAdvice = [
    {
      'title': 'Watering Recommendation',
      'content':
          'Reduce watering today due to expected rain. Check soil moisture before next watering.',
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'priority': 'high',
    },
    {
      'title': 'Pest Alert',
      'content':
          'High humidity conditions favor aphid development. Monitor plants closely.',
      'icon': Icons.bug_report,
      'color': Colors.orange,
      'priority': 'medium',
    },
    {
      'title': 'Planting Window',
      'content':
          'Good conditions for transplanting seedlings this week. Mild temperatures expected.',
      'icon': Icons.local_florist,
      'color': Colors.green,
      'priority': 'low',
    },
    {
      'title': 'Disease Prevention',
      'content':
          'Apply fungicide before Wednesday\'s rain to prevent fungal diseases.',
      'icon': Icons.healing,
      'color': Colors.purple,
      'priority': 'high',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather & Advice'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _showLocationDialog,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Weather Card
              _buildCurrentWeatherCard(),
              const SizedBox(height: 24),

              // 5-Day Forecast
              _buildForecastSection(),
              const SizedBox(height: 24),

              // Farming Advice
              _buildFarmingAdviceSection(),
              const SizedBox(height: 24),

              // Weather Alerts
              _buildWeatherAlertsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
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
                Text(
                  _currentWeather['location'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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
                        '${_currentWeather['temperature']}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentWeather['condition'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.wb_cloudy,
                  size: 80,
                  color: Colors.white70,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail('Humidity',
                    '${_currentWeather['humidity']}%', Icons.water_drop),
                _buildWeatherDetail(
                    'Wind', '${_currentWeather['windSpeed']} km/h', Icons.air),
                _buildWeatherDetail('UV Index', '${_currentWeather['uvIndex']}',
                    Icons.wb_sunny),
              ],
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
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastSection() {
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
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.length,
            itemBuilder: (context, index) {
              final day = _forecast[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day['day'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(day['icon'], size: 24),
                        const SizedBox(height: 8),
                        Text(
                          '${day['high']}°/${day['low']}°',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${day['precipitation']}%',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
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

  Widget _buildFarmingAdviceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farming Advice',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._farmingAdvice.map((advice) => _buildAdviceCard(advice)),
      ],
    );
  }

  Widget _buildAdviceCard(Map<String, dynamic> advice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: advice['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                advice['icon'],
                color: advice['color'],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        advice['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(advice['priority']),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          advice['priority'].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    advice['content'],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherAlertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weather Alerts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.orange.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Heavy Rain Warning',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Heavy rainfall expected Wednesday. Ensure proper drainage and protect young plants.',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.my_location),
              title: const Text('Current Location'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Location updated to Current Location')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('San Francisco, CA'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Location updated to San Francisco, CA')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Los Angeles, CA'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Location updated to Los Angeles, CA')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshWeatherData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Weather data updated!')),
    );
  }
}
