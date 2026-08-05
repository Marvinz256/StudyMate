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
        applicationId = "com.marvinz256.studymate"
        minSdk = 21
        targetSdk = 34
        versionCode = flutter.versionCode.toInteger()
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // We will add signing later in Codemagic
        }
    }
}

flutter {
    source = "../.."
}
