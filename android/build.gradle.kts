//buildscript {
//    repositories {
//        google()
//        mavenCentral()
//    }
//    dependencies {
//        classpath("com.android.tools.build:gradle:8.2.2")
//        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22")
//        classpath("com.google.gms:google-services:4.4.1")
//    }
//}
//
//plugins {
//    id("com.google.gms.google-services") version "4.4.1" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.buildDir)
//}




buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.1.0") // ✅ Updated
        classpath("com.google.gms:google-services:4.4.1")
    }
}

plugins {
    id("com.google.gms.google-services") version "4.4.1" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
