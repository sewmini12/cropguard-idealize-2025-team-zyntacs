import 'package:flutter/material.dart';
import 'screens/homescreen.dart';
import 'screens/disease_detection.dart';
import 'screens/community.dart';
import 'screens/weather_advice.dart';
import 'screens/profile.dart';
import 'screens/bot.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  runApp(const CropGuardApp());
}

class CropGuardApp extends StatelessWidget {
  const CropGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/disease-detection': (context) => const DiseaseDetectionScreen(),
        '/community': (context) => const CommunityScreen(),
        '/weather-advice': (context) => const WeatherAdviceScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/bot': (context) => const BotScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DiseaseDetectionScreen(),
    const CommunityScreen(),
    const WeatherAdviceScreen(),
    const BotScreen(),
    const ProfileScreen(),
  ];

  // Debug: Ensure list size matches navigation items
  @override
  void initState() {
    super.initState();
    assert(_screens.length == 6, 'Screens list must have exactly 6 items');
  }

  @override
  Widget build(BuildContext context) {
    // Defensive programming: ensure index is within bounds
    final safeIndex = _currentIndex.clamp(0, _screens.length - 1);

    return Scaffold(
      body: _screens[safeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: (index) {
          // Only update if index is valid
          if (index >= 0 && index < _screens.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Detect Disease',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
