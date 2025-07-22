# Flutter Installation Script for CropGuard
Write-Host "Installing Flutter for CropGuard..." -ForegroundColor Green
Write-Host ""

# Create flutter directory
$flutterPath = "C:\flutter"
if (!(Test-Path $flutterPath)) {
    New-Item -ItemType Directory -Path $flutterPath -Force
    Write-Host "Created directory: $flutterPath" -ForegroundColor Yellow
}

Set-Location $flutterPath

# Download Flutter SDK
Write-Host "Downloading Flutter SDK..." -ForegroundColor Yellow
$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip"
$output = "$flutterPath\flutter.zip"

try {
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
    Write-Host "Download completed!" -ForegroundColor Green
} catch {
    Write-Host "Download failed: $_" -ForegroundColor Red
    exit 1
}

# Extract Flutter
Write-Host "Extracting Flutter..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $output -DestinationPath $flutterPath -Force
    Remove-Item $output  # Clean up zip file
    Write-Host "Extraction completed!" -ForegroundColor Green
} catch {
    Write-Host "Extraction failed: $_" -ForegroundColor Red
    exit 1
}

# Add to PATH
$flutterBinPath = "$flutterPath\flutter\bin"
$currentPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)

if ($currentPath -notlike "*$flutterBinPath*") {
    Write-Host "Adding Flutter to PATH..." -ForegroundColor Yellow
    $newPath = "$currentPath;$flutterBinPath"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, [EnvironmentVariableTarget]::User)
    Write-Host "Flutter added to PATH!" -ForegroundColor Green
} else {
    Write-Host "Flutter already in PATH" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Flutter installation complete!" -ForegroundColor Green
Write-Host "Please restart VS Code and run: flutter doctor" -ForegroundColor Cyan
Write-Host "Then navigate to your project and run: flutter pub get" -ForegroundColor Cyan
Write-Host ""
