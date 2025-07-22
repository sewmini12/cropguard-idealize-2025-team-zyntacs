# Weather API Configuration

## Setting up OpenWeatherMap API (Optional but Recommended)

1. **Get a free API key:**
   - Visit [OpenWeatherMap](https://openweathermap.org/api)
   - Sign up for a free account
   - Get your API key from the dashboard

2. **Configure the API key:**
   - Open `lib/services/weather_service.dart`
   - Replace `'YOUR_API_KEY_HERE'` with your actual API key:
   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

3. **Free Alternative:**
   - If you don't want to use OpenWeatherMap, the app automatically falls back to the free Open-Meteo API
   - No API key required for Open-Meteo
   - Provides basic weather data and forecasts

## Weather Data Sources

### OpenWeatherMap (Recommended)
- **Pros:** More detailed data, UV index, better accuracy
- **Cons:** Requires API key (free tier: 1000 calls/day)
- **Data includes:** Temperature, humidity, wind, UV index, detailed conditions

### Open-Meteo (Free Alternative)
- **Pros:** No API key required, unlimited requests
- **Cons:** Limited data fields, no UV index
- **Data includes:** Temperature, humidity, wind, basic conditions

## Location Services

The app supports multiple location options:

1. **GPS Location (Recommended)**
   - Uses device GPS for accurate location
   - Requires location permissions
   - Most accurate weather data

2. **Manual City Entry**
   - Enter any city name
   - Works without GPS
   - Good for planning trips

3. **Saved Locations**
   - App remembers your last location
   - Faster startup times
   - Works offline for location data

## Permissions Required

### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to provide accurate weather data for your farming area.</string>
```

## Troubleshooting

### Weather not loading?
1. Check internet connection
2. Verify API key is correct (if using OpenWeatherMap)
3. Check location permissions
4. Try manual city entry

### Location not working?
1. Enable location services in device settings
2. Grant app permission to use location
3. Try manual city selection
4. Check if GPS is enabled

### Inaccurate weather data?
1. Verify your location is correct
2. Try refreshing the weather data
3. Check if you're using the right city name
4. Switch between GPS and manual location

## Features Included

✅ Real-time weather data  
✅ 5-day weather forecast  
✅ Smart farming advice  
✅ GPS location support  
✅ Manual location entry  
✅ Location persistence  
✅ Offline fallback  
✅ Multiple weather APIs  
✅ Weather-based recommendations  
✅ UV index monitoring  
✅ Wind and humidity alerts  
✅ Temperature warnings  

## API Rate Limits

### OpenWeatherMap Free Tier
- 1,000 API calls per day
- 60 calls per minute
- More than enough for typical farming app usage

### Open-Meteo
- No rate limits
- Unlimited requests
- Great for high-frequency updates

The app is designed to work efficiently with these limits by:
- Caching weather data
- Reasonable refresh intervals
- Smart error handling
- Automatic API switching
