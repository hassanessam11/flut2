plugins {
    id("com.android.application")
    kotlin("android")  // إزالة النسخة هنا
}

android {
    compileSdkVersion(30)

    defaultConfig {
        applicationId = "com.example.solidaritysmsapp"
        minSdkVersion(21)
        targetSdkVersion(30)
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }

    // إعدادات Kotlin
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7")  // تم إزالة تحديد النسخة هنا أيضًا
    implementation("com.android.tools.build:gradle:7.0.2")  // تأكد من توافقه مع Gradle و Java
    implementation("androidx.appcompat:appcompat:1.3.1")
    implementation("androidx.constraintlayout:constraintlayout:2.0.4")
    implementation("com.google.android.material:material:1.4.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.3.1")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.3.1")
}

repositories {
    google()
    mavenCentral()
}
