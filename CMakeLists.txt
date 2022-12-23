project(androidcmakeexample)

cmake_minimum_required(VERSION 3.4.1)

set(ANDROID_ABI arm64-v8a)
set(ANDROID_STL c++_static)
set(ANDROID_PLATFORM android-27)

# include("$ENV{ANDROID_CMAKE_HOME}/android.apk.cmake" REQUIRED)

# compiler flags
# set(CMAKE_CXX_FLAGS
#   "-std=c++11 -ffor-scope -fno-exceptions -pipe -ffunction-sections -fdata-sections -ffast-math -pedantic -Werror -Wnon-virtual-dtor -Wsign-promo -fvisibility=hidden -fvisibility-inlines-hidden -Wstrict-null-sentinel -Os -funroll-all-loops -fpeel-loops -ftree-vectorize")

# include_directories($ENV{ANDROID_NDK_HOME}/sources/android/native_app_glue)


# Sources
# set(SOURCES 
  
#   "$ENV{ANDROID_NDK_HOME}/sources/android/native_app_glue/android_native_app_glue.c")

# add_executable(androidcmakeexample ${SOURCES})
# target_link_libraries(androidcmakeexample log android)
# set_target_properties(androidcmakeexample PROPERTIES COMPILE_DEFINITIONS "ANDROID")
# android_create_apk(androidcmakeexample "org.discordia.cmake.example" 
#   "${CMAKE_BINARY_DIR}/apk" "${CMAKE_SOURCE_DIR}/libs" "${CMAKE_SOURCE_DIR}/android" "${CMAKE_SOURCE_DIR}/assets")

file(TO_CMAKE_PATH $ENV{ANDROID_NDK_HOME} ANDROID_NDK_HOME_CMAKE)
add_library(native_app_glue STATIC ${ANDROID_NDK_HOME_CMAKE}/sources/android/native_app_glue/android_native_app_glue.c)

# now build app's shared lib
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv8-a -fPIC -std=gnu++11")
#  --sysroot=${ANDROID_NDK_HOME_CMAKE}/toolchains/llvm/prebuilt/windows-x86_64/sysroot

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -Wall -Werror -ffor-scope -fno-exceptions -pipe -ffunction-sections -fdata-sections -ffast-math -pedantic -Wnon-virtual-dtor -Wsign-promo -fvisibility=hidden -fvisibility-inlines-hidden -Os -ftree-vectorize")

# Export ANativeActivity_onCreate(),
# Refer to: https://github.com/android-ndk/ndk/issues/381.
set(CMAKE_SHARED_LINKER_FLAGS
    "${CMAKE_SHARED_LINKER_FLAGS} -u ANativeActivity_onCreate")


add_library(androidcmakeexample SHARED "src/main.cpp")

target_include_directories(androidcmakeexample PRIVATE
  ${ANDROID_NDK_HOME_CMAKE}/sources/android/native_app_glue)

# add lib dependencies
target_link_libraries(androidcmakeexample
    android
    native_app_glue
    EGL
    GLESv1_CM
    log)

# add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/bin/NativeActivity.unsigned.apk
#     COMMAND ${BUILD_TOOLS}/aapt package -f -M AndroidManifest.xml -S res
#     -I ${ANDROID_HOME}/platforms/android-29/android.jar -F ${CMAKE_BINARY_DIR}/bin/NativeActivity.unsigned.apk bin
#     COMMAND ${BUILD_TOOLS}/aapt add ${CMAKE_BINARY_DIR}/bin/NativeActivity.unsigned.apk ${CMAKE_BINARY_DIR}/libandroidcmakeexample.so
#     DEPENDS ${CMAKE_BINARY_DIR}/libandroidcmakeexample.so
#     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
#     COMMENT "Creating bin/NativeActivity.unsigned.apk.")


# add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/src/com/example/native_activity/R.java
#     COMMAND ${BUILD_TOOLS}/aapt package -f -m  -S res -J src -M AndroidManifest.xml -I ${ANDROID_HOME}/platforms/android-29/android.jar
#     DEPENDS res/values/strings.xml
#     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
#     COMMENT "Creating src/com/example/native_activity/R.java.")

# add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/obj/com/example/native_activity/R.class
#     COMMAND $ENV{JAVA_HOME}/bin/javac -source 1.7 -target 1.7 -d obj -classpath ${ANDROID_HOME}/platforms/android-29/android.jar -sourcepath src src/com/example/native_activity/R.java
#     DEPENDS src/com/example/native_activity/R.java
#     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
#     COMMENT "Creating obj/com/example/native_activity/R.class.")