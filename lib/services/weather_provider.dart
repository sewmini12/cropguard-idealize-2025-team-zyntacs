import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherData? _currentWeather;
  List<ForecastData> _forecast = [];
  List<FarmingAdvice> _farmingAdvice = [];
  bool _isLoading = false;
  String? _error;
  String _currentLocation = 'Current Location';

  // Getters
  WeatherData? get currentWeather => _currentWeather;
  List<ForecastData> get forecast => _forecast;
  List<FarmingAdvice> get farmingAdvice => _farmingAdvice;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentLocation => _currentLocation;

  /// Initialize weather data with current location
  Future<void> initializeWeatherData() async {
    await loadWeatherData();
  }

  /// Load weather data for current location
  Future<void> loadWeatherData() async {
    _setLoading(true);
    _setError(null);

    try {
      // Try to get saved location first
      final savedLocation = await LocationService.getSavedLocation();

      if (savedLocation != null &&
          savedLocation['latitude'] != null &&
          savedLocation['longitude'] != null) {
        // Use saved location
        await _loadWeatherForCoordinates(
          savedLocation['latitude'],
          savedLocation['longitude'],
          savedLocation['name'],
        );
      } else {
        // Use current location
        await _loadCurrentLocationWeather();
      }
    } catch (e) {
      _setError('Failed to load weather data: $e');
      _loadMockData(); // Fallback to mock data
    } finally {
      _setLoading(false);
    }
  }

  /// Load weather data for current GPS location
  Future<void> _loadCurrentLocationWeather() async {
    final position = await LocationService.getCurrentPosition();

    if (position != null) {
      final locationName = LocationService.getLocationName(
        position.latitude,
        position.longitude,
      );

      await _loadWeatherForCoordinates(
        position.latitude,
        position.longitude,
        locationName,
      );

      // Save current location
      await LocationService.saveLocation(
        locationName,
        position.latitude,
        position.longitude,
      );
    } else {
      throw Exception('Could not get current location');
    }
  }

  /// Load weather data for specific coordinates
  Future<void> _loadWeatherForCoordinates(
      double lat, double lon, String locationName) async {
    // Load current weather
    final weather =
        await WeatherService.getCurrentWeatherByCoordinates(lat, lon);
    if (weather != null) {
      _currentWeather = weather;
      _currentLocation = locationName;
    }

    // Load forecast
    final forecastData = await WeatherService.getForecast(lat, lon);
    _forecast = forecastData;

    // Generate farming advice
    if (_currentWeather != null) {
      _farmingAdvice =
          WeatherService.generateFarmingAdvice(_currentWeather!, _forecast);
    }

    notifyListeners();
  }

  /// Load weather data for a specific city
  Future<void> loadWeatherForCity(String cityName) async {
    _setLoading(true);
    _setError(null);

    try {
      final weather = await WeatherService.getCurrentWeatherByCity(cityName);
      if (weather != null) {
        _currentWeather = weather;
        _currentLocation = cityName;

        // Get forecast if coordinates are available
        if (weather.latitude != null && weather.longitude != null) {
          final forecastData = await WeatherService.getForecast(
            weather.latitude!,
            weather.longitude!,
          );
          _forecast = forecastData;
        }

        // Generate farming advice
        _farmingAdvice =
            WeatherService.generateFarmingAdvice(_currentWeather!, _forecast);

        // Save location
        await LocationService.saveLocation(
          cityName,
          weather.latitude,
          weather.longitude,
        );

        notifyListeners();
      } else {
        _setError('Could not find weather data for $cityName');
      }
    } catch (e) {
      _setError('Failed to load weather data for $cityName: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Refresh current weather data
  Future<void> refreshWeatherData() async {
    await loadWeatherData();
  }

  /// Load mock data as fallback
  void _loadMockData() {
    _currentWeather = WeatherData(
      temperature: 24.0,
      humidity: 65,
      windSpeed: 8.0,
      condition: 'Partly Cloudy',
      precipitation: 20,
      uvIndex: 6,
      location: 'Sample Location',
      description: 'Partly cloudy with mild temperatures',
    );

    _forecast = [
      ForecastData(
        day: 'Today',
        high: 26.0,
        low: 18.0,
        condition: 'Partly Cloudy',
        precipitation: 20,
        icon: 'wb_cloudy',
        date: DateTime.now(),
      ),
      ForecastData(
        day: 'Tomorrow',
        high: 28.0,
        low: 20.0,
        condition: 'Sunny',
        precipitation: 5,
        icon: 'wb_sunny',
        date: DateTime.now().add(const Duration(days: 1)),
      ),
      ForecastData(
        day: 'Wednesday',
        high: 22.0,
        low: 16.0,
        condition: 'Rainy',
        precipitation: 85,
        icon: 'grain',
        date: DateTime.now().add(const Duration(days: 2)),
      ),
      ForecastData(
        day: 'Thursday',
        high: 25.0,
        low: 19.0,
        condition: 'Cloudy',
        precipitation: 30,
        icon: 'cloud',
        date: DateTime.now().add(const Duration(days: 3)),
      ),
      ForecastData(
        day: 'Friday',
        high: 29.0,
        low: 22.0,
        condition: 'Sunny',
        precipitation: 0,
        icon: 'wb_sunny',
        date: DateTime.now().add(const Duration(days: 4)),
      ),
    ];

    _farmingAdvice = [
      FarmingAdvice(
        title: 'Watering Recommendation',
        content:
            'Reduce watering today due to expected rain. Check soil moisture before next watering.',
        icon: 'water_drop',
        color: 'blue',
        priority: 'high',
        category: 'watering',
      ),
      FarmingAdvice(
        title: 'Pest Alert',
        content:
            'High humidity conditions favor aphid development. Monitor plants closely.',
        icon: 'bug_report',
        color: 'orange',
        priority: 'medium',
        category: 'pest',
      ),
      FarmingAdvice(
        title: 'Planting Window',
        content:
            'Good conditions for transplanting seedlings this week. Mild temperatures expected.',
        icon: 'local_florist',
        color: 'green',
        priority: 'low',
        category: 'planting',
      ),
    ];

    _currentLocation = 'Sample Location';
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
