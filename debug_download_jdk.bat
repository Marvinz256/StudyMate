@echo off
cd /d "%~dp0"
if exist curl_debug.txt del /f /q curl_debug.txt
if exist openjdk17.zip del /f /q openjdk17.zip
C:\Windows\System32\curl.exe -L -o openjdk17.zip -w "URL:%{url_effective}\nCODE:%{http_code}\nSIZE:%{size_download}\n" "https://github.com/adoptium/temurin17-binaries/releases/latest/download/OpenJDK17U-jdk_x64_windows_hotspot.zip" >> curl_debug.txt 2>&1
if exist openjdk17.zip (dir openjdk17.zip >> curl_debug.txt 2>&1 && certutil -hashfile openjdk17.zip SHA256 >> curl_debug.txt 2>&1) else echo NO_FILE >> curl_debug.txt
C:\Windows\System32\tar.exe -tf openjdk17.zip 2>> curl_debug.txt >> curl_debug.txt
exit /b %errorlevel%