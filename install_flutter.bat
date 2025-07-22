@echo off
echo Installing Flutter for CropGuard...
echo.

REM Create flutter directory
if not exist "C:\flutter" mkdir "C:\flutter"
cd "C:\flutter"

echo Downloading Flutter SDK...
powershell -Command "& {Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip' -OutFile 'flutter.zip'}"

echo Extracting Flutter...
powershell -Command "& {Expand-Archive -Path 'flutter.zip' -DestinationPath '.' -Force}"

echo Adding Flutter to PATH...
setx PATH "%PATH%;C:\flutter\flutter\bin" /M

echo.
echo Flutter installation complete!
echo Please restart VS Code and run: flutter doctor
echo.
pause
