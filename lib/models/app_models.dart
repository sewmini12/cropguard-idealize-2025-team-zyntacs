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

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
    required this.precipitation,
    required this.uvIndex,
    required this.location,
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
