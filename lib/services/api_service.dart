import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_models.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'YOUR_API_KEY_HERE'; // Replace with actual API key

  static Future<WeatherData?> getCurrentWeather(String location) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/weather?q=$location&appid=$_apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData(
          temperature: data['main']['temp'].toDouble(),
          humidity: data['main']['humidity'],
          windSpeed: data['wind']['speed'].toDouble(),
          condition: data['weather'][0]['main'],
          precipitation: data['clouds']['all'] ?? 0,
          uvIndex: 0, // UV index requires separate API call
          location: data['name'],
        );
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
    return null;
  }

  static Future<List<WeatherData>> getForecast(String location) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/forecast?q=$location&appid=$_apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> forecasts = data['list'];
        
        return forecasts.take(5).map((forecast) {
          return WeatherData(
            temperature: forecast['main']['temp'].toDouble(),
            humidity: forecast['main']['humidity'],
            windSpeed: forecast['wind']['speed'].toDouble(),
            condition: forecast['weather'][0]['main'],
            precipitation: forecast['clouds']['all'] ?? 0,
            uvIndex: 0,
            location: data['city']['name'],
          );
        }).toList();
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
    }
    return [];
  }
}

class DiseaseDetectionService {
  static Future<DiseaseAnalysis?> analyzePlantImage(String imagePath) async {
    try {
      // This would typically upload the image and get analysis
      // For now, return mock data
      await Future.delayed(const Duration(seconds: 2));
      
      return DiseaseAnalysis(
        disease: 'Tomato Late Blight',
        confidence: 87,
        severity: 'Medium',
        description: 'Late blight is a destructive disease that affects tomato plants, causing dark lesions on leaves and stems.',
        treatments: [
          'Remove affected leaves immediately',
          'Apply copper-based fungicide',
          'Improve air circulation',
          'Reduce watering frequency',
        ],
        prevention: [
          'Plant resistant varieties',
          'Ensure good drainage',
          'Avoid overhead watering',
          'Practice crop rotation',
        ],
      );
    } catch (e) {
      print('Error analyzing plant image: $e');
    }
    return null;
  }
}

class CommunityService {
  static Future<List<Post>> getPosts() async {
    try {
      // Mock data - in real app, this would fetch from your backend
      await Future.delayed(const Duration(seconds: 1));
      
      return [
        Post(
          id: 1,
          author: 'GreenThumb_Sarah',
          authorAvatar: 'S',
          time: '2 hours ago',
          content: 'Just discovered an amazing natural pesticide recipe! Mix neem oil with soapy water.',
          likes: 23,
          comments: 5,
          tags: ['pest-control', 'organic', 'tips'],
          type: PostType.tip,
        ),
        // Add more mock posts here
      ];
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return [];
  }

  static Future<bool> createPost(String content, PostType type, List<String> tags) async {
    try {
      // In real app, this would send data to your backend
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Error creating post: $e');
    }
    return false;
  }
}
