# CropGuard Flutter Setup Guide

## Quick Start Instructions

### Option 1: Install Flutter (Recommended)

1. **Download Flutter SDK:**
   - Go to https://docs.flutter.dev/get-started/install/windows
   - Download the Flutter SDK for Windows
   - Extract to `C:\flutter`

2. **Add to PATH:**
   - Add `C:\flutter\flutter\bin` to your system PATH
   - Restart VS Code

3. **Verify Installation:**
   ```bash
   flutter doctor
   ```

4. **Run CropGuard:**
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

### Option 2: Use Provided Installation Scripts

Run one of these scripts as Administrator:

**PowerShell (Recommended):**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install_flutter.ps1
```

**Batch File:**
```cmd
install_flutter.bat
```

### Option 3: Manual Installation

1. Open PowerShell as Administrator
2. Run these commands:

```powershell
# Create directory
New-Item -ItemType Directory -Path "C:\flutter" -Force

# Download Flutter
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip" -OutFile "C:\flutter\flutter.zip"

# Extract
Expand-Archive -Path "C:\flutter\flutter.zip" -DestinationPath "C:\flutter" -Force

# Add to PATH (restart required)
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\flutter\flutter\bin", [EnvironmentVariableTarget]::User)
```

## After Installation

1. **Restart VS Code**
2. **Install Flutter extension** (if not already installed)
3. **Run Flutter Doctor:**
   ```bash
   flutter doctor
   ```
4. **Get Dependencies:**
   ```bash
   cd d:\figmatest
   flutter pub get
   ```
5. **Run the App:**
   ```bash
   flutter run -d chrome
   ```

## CropGuard Features

Your Flutter app includes:

✅ **Multi-screen Navigation** - Home, Disease Detection, Community, Weather, Profile
✅ **Disease Detection** - AI-powered plant disease identification
✅ **Community Platform** - Share tips, problems, and solutions
✅ **Weather Integration** - Farming advice based on weather data
✅ **User Profile** - Track progress and achievements
✅ **Responsive Design** - Works on web, mobile, and desktop

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/
│   └── app_models.dart    # Data models
├── screens/
│   ├── homescreen.dart    # Home dashboard
│   ├── disease_detection.dart # AI analysis
│   ├── community.dart     # Social features
│   ├── weather_advice.dart # Weather data
│   └── profile.dart       # User profile
└── services/
    └── api_service.dart   # API integrations
```

## Next Steps

1. **API Integration:**
   - Add weather API key in `api_service.dart`
   - Connect disease detection AI service
   - Set up community backend

2. **Customization:**
   - Update app theme and colors
   - Add your own plant disease database
   - Customize weather locations

3. **Deployment:**
   - Test on different devices
   - Build for production: `flutter build web`
   - Deploy to your preferred hosting platform

## Troubleshooting

- **Flutter not found:** Restart VS Code after installation
- **Dependencies error:** Run `flutter clean && flutter pub get`
- **Web issues:** Ensure Chrome is installed and updated
- **Build errors:** Check `flutter doctor` for missing dependencies

Happy farming! 🌱
