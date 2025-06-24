@echo off
"C:\\Users\\sdeve\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\sdeve\\Flutter SDK\\flutter_windows_3.29.3-stable\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=23" ^
  "-DANDROID_PLATFORM=android-23" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=C:\\Users\\sdeve\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\sdeve\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\sdeve\\AppData\\Local\\Android\\Sdk\\ndk\\21.4.7075529\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\sdeve\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\Users\\sdeve\\AndroidStudioProjects\\yummy_fly_v3\\android\\app\\build\\intermediates\\cxx\\Debug\\262w6q4p\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\Users\\sdeve\\AndroidStudioProjects\\yummy_fly_v3\\android\\app\\build\\intermediates\\cxx\\Debug\\262w6q4p\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\Users\\sdeve\\AndroidStudioProjects\\yummy_fly_v3\\android\\app\\.cxx\\Debug\\262w6q4p\\x86_64" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
