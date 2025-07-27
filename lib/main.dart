import 'package:flutter/material.dart';
import 'screens/homescreen.dart';
import 'screens/disease_detection.dart';
import 'screens/community.dart';
import 'screens/weather_advice.dart';
import 'screens/profile.dart';
import 'screens/ai_assistant_screen.dart';
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
        '/ai-assistant': (context) => const AIAssistantScreen(),
      },
    );
  }
}

class IconWithCircle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;

  const IconWithCircle({
    super.key,
    required this.icon,
    this.iconColor = Colors.green,
    this.backgroundColor = Colors.grey,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
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
    const AIAssistantScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    assert(_screens.length == 6, 'Screens list must have exactly 6 items');
  }

  @override
  Widget build(BuildContext context) {
    final safeIndex = _currentIndex.clamp(0, _screens.length - 1);

    return Scaffold(
      body: _screens[safeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: (index) {
          if (index >= 0 && index < _screens.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.camera_alt),
            label: 'Detect',
          ),
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.smart_toy),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: IconWithCircle(icon: Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
