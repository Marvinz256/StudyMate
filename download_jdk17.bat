@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
if exist openjdk17.zip del /f /q "openjdk17.zip"
echo Downloading OpenJDK 17...
curl.exe -L -o "openjdk17.zip" "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.20+8/OpenJDK17U-jdk_x64_windows_hotspot.zip"
if errorlevel 1 (
  echo Failed to download OpenJDK 17
  exit /b 1
)
if not exist openjdk17.zip (
  echo Download failed: openjdk17.zip missing
  exit /b 1
)
for %%F in (openjdk17.zip) do set SIZE=%%~zF
if "%SIZE%"=="0" (
  echo Downloaded zip has zero length
  exit /b 1
)
echo Download complete, size=!SIZE! bytes
if exist openjdk17 mkdir openjdk17
if exist openjdk17\* rmdir /s /q openjdk17
mkdir openjdk17
echo Extracting OpenJDK 17...
tar.exe -xf "openjdk17.zip" -C "openjdk17"
if errorlevel 1 (
  echo Extraction failed
  exit /b 1
)
dir /b openjdk17
exit /b 0
