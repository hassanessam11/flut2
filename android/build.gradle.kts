buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.0.2")  // استخدام الصيغة الصحيحة لـ Kotlin DSL
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
