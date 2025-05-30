buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.1") // ✅ Update
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22") // ✅ Update
    }
}

allprojects {
    repositories {
        google()
        mavenCentral() 
    }
}

// Configure build directory for all projects
rootProject.layout.buildDirectory.set(rootProject.layout.projectDirectory.dir("build"))

subprojects {
    project.layout.buildDirectory.set(rootProject.layout.buildDirectory.dir(project.name))
}

// Optional: configure custom build directory (be cautious!)
// rootProject.layout.buildDirectory.set(rootProject.layout.projectDirectory.dir("../build"))

// subprojects {
//     project.layout.buildDirectory.set(rootProject.layout.buildDirectory.dir(project.name))
// }


