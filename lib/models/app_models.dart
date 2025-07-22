class Post {
  final int id;
  final String author;
  final String authorAvatar;
  final String time;
  final String content;
  final int likes;
  final int comments;
  final List<String> tags;
  final PostType type;

  Post({
    required this.id,
    required this.author,
    required this.authorAvatar,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.tags,
    required this.type,
  });
}

enum PostType { tip, problem, question, success }

class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String condition;
  final int precipitation;
  final int uvIndex;
  final String location;
  final double? latitude;
  final double? longitude;
  final DateTime? date;
  final double? tempMin;
  final double? tempMax;
  final String? description;
  final String? icon;
  final double? pressure;
  final int? visibility;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
    required this.precipitation,
    required this.uvIndex,
    required this.location,
    this.latitude,
    this.longitude,
    this.date,
    this.tempMin,
    this.tempMax,
    this.description,
    this.icon,
    this.pressure,
    this.visibility,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']?['speed']?.toDouble() ?? 0.0,
      condition: json['weather'][0]['main'],
      precipitation: json['clouds']?['all'] ?? 0,
      uvIndex: json['uvi']?.toInt() ?? 0,
      location: json['name'] ?? 'Unknown',
      latitude: json['coord']?['lat']?.toDouble(),
      longitude: json['coord']?['lon']?.toDouble(),
      tempMin: json['main']['temp_min']?.toDouble(),
      tempMax: json['main']['temp_max']?.toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      pressure: json['main']['pressure']?.toDouble(),
      visibility: json['visibility'],
    );
  }
}

class ForecastData {
  final String day;
  final double high;
  final double low;
  final String condition;
  final int precipitation;
  final String icon;
  final DateTime date;

  ForecastData({
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.precipitation,
    required this.icon,
    required this.date,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json, DateTime date) {
    return ForecastData(
      day: formatDay(date),
      high: json['main']['temp_max'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      condition: json['weather'][0]['main'],
      precipitation: json['pop'] != null ? (json['pop'] * 100).toInt() : 0,
      icon: json['weather'][0]['icon'],
      date: date,
    );
  }

  static String formatDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) return 'Today';
    if (dateOnly == tomorrow) return 'Tomorrow';

    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }
}

class FarmingAdvice {
  final String title;
  final String content;
  final String icon;
  final String color;
  final String priority;
  final String category;

  FarmingAdvice({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.priority,
    required this.category,
  });
}

class DiseaseAnalysis {
  final String disease;
  final int confidence;
  final String severity;
  final String description;
  final List<String> treatments;
  final List<String> prevention;

  DiseaseAnalysis({
    required this.disease,
    required this.confidence,
    required this.severity,
    required this.description,
    required this.treatments,
    required this.prevention,
  });
}

class UserProfile {
  final String name;
  final String email;
  final String location;
  final String joinDate;
  final String avatar;
  final String gardenSize;
  final String experienceLevel;
  final List<String> specialties;

  UserProfile({
    required this.name,
    required this.email,
    required this.location,
    required this.joinDate,
    required this.avatar,
    required this.gardenSize,
    required this.experienceLevel,
    required this.specialties,
  });
}
