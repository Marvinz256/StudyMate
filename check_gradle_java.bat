@echo off
cd /d "%~dp0android"
echo CWD=%CD%
echo PATH=%PATH%
echo JAVA_HOME=%JAVA_HOME%
"%CD%\gradlew.bat" -version >..\gradle_version_default.txt 2>&1
set JAVA_HOME=C:\Program Files\Android\Android Studio1\jbr
set PATH=%JAVA_HOME%\bin;%PATH%
echo SET JAVA_HOME=%JAVA_HOME% >>..\gradle_version_default.txt
"%CD%\gradlew.bat" -version >>..\gradle_version_default.txt 2>&1
if exist ..\gradle_version_default.txt (
  type ..\gradle_version_default.txt
)
