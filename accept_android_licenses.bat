@echo off
set "JAVA_HOME=C:\Program Files\Android\Android Studio1\jbr"
set "ANDROID_SDK_ROOT=C:\Users\MARVIN 256\AppData\Local\Android\sdk"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "ANS_FILE=%TEMP%\android-licenses.txt"
break > "%ANS_FILE%"
for /L %%i in (1,1,20) do echo y>>"%ANS_FILE%"
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" --sdk_root="%ANDROID_SDK_ROOT%" --licenses < "%ANS_FILE%"
del "%ANS_FILE%"
