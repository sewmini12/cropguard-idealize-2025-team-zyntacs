# Weather Integration Documentation

## Overview

This document describes the real-time weather integration in the CropGuard application. The weather system provides comprehensive weather data and farming advice to help farmers make informed decisions.

## Architecture

### File Structure
```
lib/
├── models/
│   └── app_models.dart          # Data models for weather and farming advice
├── services/
│   ├── weather_service.dart     # Core weather API service
│   ├── location_service.dart    # Location management
│   └── weather_provider.dart    # State management for weather data
├── widgets/
│   └── weather/
│       ├── current_weather_card.dart    # Current weather display
│       ├── forecast_section.dart        # 5-day forecast
│       ├── farming_advice_section.dart  # AI-generated farming advice
│       └── location_dialog.dart         # Location selection dialog
└── screens/
    └── weather_advice.dart      # Main weather screen
```

## Components

### 1. Weather Service (`weather_service.dart`)
The main service for fetching weather data from multiple sources:

**Features:**
- Support for OpenWeatherMap API (requires API key)
- Fallback to free Open-Meteo API
- Current weather by coordinates or city name
- 5-day weather forecast
- UV index data
- Automatic farming advice generation

**Usage:**
```dart
// Get current weather for coordinates
WeatherData? weather = await WeatherService.getCurrentWeatherByCoordinates(lat, lon);

// Get current weather for city
WeatherData? weather = await WeatherService.getCurrentWeatherByCity("San Francisco");

// Get 5-day forecast
List<ForecastData> forecast = await WeatherService.getForecast(lat, lon);
```

### 2. Location Service (`location_service.dart`)
Manages location permissions and GPS functionality:

**Features:**
- Location permission handling
- GPS coordinate retrieval
- Location data persistence
- Distance calculations

**Usage:**
```dart
// Check and request location permissions
bool hasPermission = await LocationService.checkLocationPermission();

// Get current GPS position
Position? position = await LocationService.getCurrentPosition();

// Save location to preferences
await LocationService.saveLocation("San Francisco", 37.7749, -122.4194);
```

### 3. Weather Provider (`weather_provider.dart`)
State management using ChangeNotifier pattern:

**Features:**
- Reactive state management
- Loading and error states
- Automatic farming advice generation
- Location persistence

**Usage:**
```dart
WeatherProvider weatherProvider = WeatherProvider();
await weatherProvider.initializeWeatherData();

// Listen to changes
weatherProvider.addListener(() {
  // UI will rebuild automatically
});
```

### 4. Data Models (`app_models.dart`)

#### WeatherData
Contains comprehensive weather information:
```dart
class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String condition;
  final int precipitation;
  final int uvIndex;
  final String location;
  // ... additional fields
}
```

#### ForecastData
5-day forecast information:
```dart
class ForecastData {
  final String day;
  final double high;
  final double low;
  final String condition;
  final int precipitation;
  final String icon;
  final DateTime date;
}
```

#### FarmingAdvice
AI-generated farming recommendations:
```dart
class FarmingAdvice {
  final String title;
  final String content;
  final String icon;
  final String color;
  final String priority;
  final String category;
}
```

## Setup Instructions

### 1. API Key Configuration
To use real weather data with OpenWeatherMap:

1. Sign up at [OpenWeatherMap](https://openweathermap.org/api)
2. Get your free API key
3. Update `weather_service.dart`:
```dart
static const String _apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

### 2. Android Permissions
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### 3. iOS Permissions
Add to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to provide weather data for your area.</string>
```

## Features

### Real-time Weather Data
- Current temperature, humidity, wind speed
- Weather conditions and descriptions
- UV index and visibility
- 5-day detailed forecast

### Smart Farming Advice
The system automatically generates farming advice based on weather conditions:

**Temperature-based:**
- Heat stress alerts for high temperatures (>30°C)
- Frost protection warnings for low temperatures (<5°C)

**Humidity-based:**
- Fungal disease prevention for high humidity (>80%)
- Ventilation recommendations

**Precipitation-based:**
- Watering schedule adjustments
- Drainage recommendations
- Planting window suggestions

**Wind-based:**
- Strong wind warnings (>20 km/h)
- Spraying schedule adjustments

### Location Management
- GPS-based current location
- Manual city selection
- Location persistence
- Popular cities list

## Usage Examples

### Basic Implementation
```dart
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherProvider _weatherProvider;

  @override
  void initState() {
    super.initState();
    _weatherProvider = WeatherProvider();
    _initializeWeather();
  }

  Future<void> _initializeWeather() async {
    await _weatherProvider.initializeWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _weatherProvider,
        builder: (context, child) {
          if (_weatherProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            child: Column(
              children: [
                if (_weatherProvider.currentWeather != null)
                  CurrentWeatherCard(weather: _weatherProvider.currentWeather!),
                ForecastSection(forecast: _weatherProvider.forecast),
                FarmingAdviceSection(advice: _weatherProvider.farmingAdvice),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### Advanced Customization
```dart
// Custom weather advice generation
List<FarmingAdvice> customAdvice = WeatherService.generateFarmingAdvice(
  weatherData, 
  forecastData
);

// Location-specific weather
await weatherProvider.loadWeatherForCity("New York, NY");

// Refresh weather data
await weatherProvider.refreshWeatherData();
```

## Error Handling

The system includes comprehensive error handling:

1. **Network Errors**: Fallback to cached data or mock data
2. **Permission Errors**: Graceful degradation to manual location entry
3. **API Errors**: Automatic fallback from OpenWeatherMap to Open-Meteo
4. **Loading States**: Clear loading indicators and error messages

## Testing

### Mock Data
When API keys are not available, the system automatically falls back to realistic mock data for testing:

```dart
// Mock weather data is automatically loaded when:
// 1. No internet connection
// 2. API key not configured
// 3. API request fails
```

### Location Testing
```dart
// Test with specific coordinates
await weatherProvider.loadWeatherForCoordinates(37.7749, -122.4194, "San Francisco");

// Test with city names
await weatherProvider.loadWeatherForCity("London, UK");
```

## Best Practices

1. **API Key Security**: Never commit API keys to version control
2. **Caching**: Implement local caching for offline functionality
3. **Error Handling**: Always provide fallback options
4. **User Experience**: Show loading states and meaningful error messages
5. **Permissions**: Request permissions at appropriate times with clear explanations

## Future Enhancements

1. **Weather Alerts**: Push notifications for severe weather
2. **Historical Data**: Weather trends and historical comparisons
3. **Crop-Specific Advice**: Tailored advice based on crop types
4. **Satellite Imagery**: Integration with weather maps
5. **Offline Mode**: Cached weather data for offline use

## Troubleshooting

### Common Issues

1. **Location Permission Denied**
   - Solution: Provide manual location entry option
   - Fallback: Use default location or last known location

2. **API Rate Limits**
   - Solution: Implement request throttling
   - Fallback: Use cached data or alternative API

3. **Network Connectivity**
   - Solution: Check connectivity before API calls
   - Fallback: Use cached data with timestamps

4. **Invalid Coordinates**
   - Solution: Validate coordinate ranges
   - Fallback: Use default location or show error message

## Performance Considerations

1. **API Calls**: Minimize unnecessary requests
2. **Caching**: Cache weather data for reasonable periods
3. **Background Updates**: Update weather data periodically
4. **Memory Management**: Dispose of providers properly
5. **Image Loading**: Optimize weather icon loading

This weather system provides a robust foundation for agricultural decision-making with real-time data and intelligent farming advice.
