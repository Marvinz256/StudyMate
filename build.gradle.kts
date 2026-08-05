plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.example.studymate" // CHANGE THIS to your real package
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.studymate" // CHANGE THIS
        minSdk = 21
        targetSdk = 34
        versionCode = flutter.versionCode.toInteger()
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}

dependencies {}
