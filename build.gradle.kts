plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.marvinz256.studymate"
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // Unique package name for Play Store
        applicationId = "com.marvinz256.studymate"
        // Minimum Android version. 21 = Android 5.0
        minSdk = 21
        // Target latest Android
        targetSdk = 34
        versionCode = flutter.versionCode.toInteger()
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for release build
            // signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
