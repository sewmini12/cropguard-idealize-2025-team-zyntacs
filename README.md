# CropGuard - Smart Farming Companion 🌱

CropGuard is a comprehensive Flutter web application designed to help cultivators identify garden diseases, share knowledge with the farming community, and receive weather-based farming advice.

> Updated: January 2025 - Latest Version

## Features

### 🔍 Disease Detection
- **AI-Powered Analysis**: Upload plant photos for instant disease identification
- **Treatment Recommendations**: Get specific treatment plans for detected diseases
- **Prevention Tips**: Learn how to prevent future occurrences
- **Confidence Scoring**: AI provides confidence levels for accurate diagnosis

### 🌤️ Weather-Based Advice
- **Current Weather**: Real-time weather data for your location
- **5-Day Forecast**: Plan your farming activities in advance
- **Farming Recommendations**: Weather-specific advice for optimal crop care
- **Weather Alerts**: Important warnings for weather conditions affecting crops

### 👥 Community Features
- **Knowledge Sharing**: Share tips, problems, and success stories
- **Expert Advice**: Get help from experienced farmers and gardeners
- **Categorized Posts**: Tips, problems, questions, and success stories
- **Interactive Comments**: Engage with the community through likes and comments
- **Tagging System**: Find relevant content easily with hashtags

### 📱 User Profile & Tracking
- **Personal Dashboard**: Track your farming journey and statistics
- **Garden Journal**: Keep notes about your plants and treatments
- **Achievement System**: Earn badges for community participation
- **Post History**: View all your contributions to the community

## App Structure

### Main Navigation
The app uses a bottom navigation bar with 5 main sections:

1. **Home**: Welcome screen with quick actions and recent tips
2. **Disease Detection**: Camera-based plant disease identification
3. **Community**: Social platform for farmers and gardeners
4. **Weather**: Weather data and farming advice
5. **Profile**: User dashboard and settings

### Key Screens

#### Home Screen
- Welcome message and app overview
- Quick action cards for main features
- Recent community tips and advice
- Easy navigation to all app sections

#### Disease Detection Screen
- Step-by-step instructions for best results
- Camera and gallery image upload options
- Real-time AI analysis with loading indicators
- Comprehensive results with treatment plans

#### Community Screen
- Tabbed interface (All Posts, Tips, Problems)
- Create new posts with categories
- Like, comment, and share functionality
- Tag-based content organization

#### Weather Advice Screen
- Current weather conditions display
- 5-day forecast with detailed information
- Farming-specific advice based on weather
- Weather alerts and warnings

#### Profile Screen
- User information and garden details
- Statistics dashboard (plants scanned, tips shared, etc.)
- Achievement system with earned badges
- Personal garden journal entries

## Technical Features

### Flutter & Dart
- Built with Flutter for cross-platform compatibility
- Material Design 3 for modern UI/UX
- Responsive design for web and mobile

### State Management
- StatefulWidget for local state management
- Future integration with Provider or Riverpod for complex state

### API Integration Ready
- Weather API integration (OpenWeatherMap)
- AI/ML service integration for disease detection
- Backend API service structure for community features

### Data Models
- Structured data models for all app entities
- Type-safe data handling with Dart classes
- Easy extensibility for new features

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Web browser for testing
- IDE (VS Code, Android Studio, or IntelliJ)

### Installation
1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to start the web app

### Dependencies
- `flutter`: UI framework
- `http`: HTTP requests for API calls
- `image_picker`: Camera and gallery access
- `shared_preferences`: Local data storage
- `intl`: Internationalization support

## API Configuration

### Weather Service
1. Sign up for OpenWeatherMap API
2. Replace `YOUR_API_KEY_HERE` in `lib/services/api_service.dart`
3. Configure location services as needed

### Disease Detection Service
1. Set up your AI/ML service endpoint
2. Update the base URL in `lib/services/api_service.dart`
3. Implement authentication if required

## Future Enhancements

### Planned Features
- **Offline Mode**: Cache critical data for offline access
- **Push Notifications**: Weather alerts and community updates
- **Multi-language Support**: Localization for global users
- **Advanced Analytics**: Detailed farming insights and trends
- **Market Prices**: Real-time crop pricing information
- **Expert Consultations**: Direct access to agricultural experts

### Technical Improvements
- **State Management**: Implement Provider or Riverpod
- **Database Integration**: Local SQLite for offline data
- **Image Caching**: Optimize image loading and storage
- **Performance Optimization**: Lazy loading and code splitting

## Contributing

We welcome contributions to CropGuard! Please feel free to submit issues, feature requests, or pull requests.

### Development Guidelines
1. Follow Flutter/Dart style guidelines
2. Write clear commit messages
3. Test your changes thoroughly
4. Update documentation as needed

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support or questions about CropGuard, please open an issue in the repository or contact our development team.

---

**CropGuard** - Empowering farmers with technology for better crop management and community collaboration.
