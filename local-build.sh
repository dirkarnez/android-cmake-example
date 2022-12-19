export current_directory=$(PWD)


export USERPROFILE=$(cygpath -u $USERPROFILE)

export ANDROID_HOME=$USERPROFILE/Downloads/commandlinetools-win-9123335_latest

export PATH=$ANDROID_HOME/cmdline-tools/bin/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH=$USERPROFILE/Downloads/cmake-3.22.2-windows-x86_64/bin:$PATH

export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/25.1.8937393
export BUILD_TOOLS=$ANDROID_HOME/build-tools/29.0.2

# export ANDROID_NDK=$USERPROFILE/android-ndk-r25b-windows/android-ndk-r25b

# export ANDROID_CMAKE_HOME=$current_directory/android-cmake


# sdkmanager.bat --list
sdkmanager.bat --sdk_root=$ANDROID_HOME --install "platform-tools" "platforms;android-29" "build-tools;29.0.2" "ndk;25.1.8937393"



# cd $ANDROID_CMAKE_HOME && \
# ls && \
# cd $current_directory && \
# ls && \
# ANDROID_NDK PORTABLE_ANDROID_HOME\ndk\25.1.8937393




# set(TOOLCHAIN "/home/amon/software/android/native-toolchain")
# set( "/home/amon/software/android")
# set( "/home/amon/software/android/build-tools/25.0.3")
# set( "/home/amon/software/android/ndk/ndk-r14b")
# set(JAVA_HOME $ENV{JAVA_HOME})

# $USERPROFILE/Downloads/PORTABLE_ANDROID_HOME/ndk/25.1.8937393/toolchains/llvm/prebuilt/windows-x86_64



echo $ANDROID_NDK_HOME && \
cd $current_directory && \
cmake.exe -G"MinGW Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE="$(cygpath -u $ANDROID_NDK_HOME\\build\\cmake\\android.toolchain.cmake)" \
    -DCMAKE_MAKE_PROGRAM="$(cygpath -u $ANDROID_NDK_HOME\\prebuilt\\windows-x86_64\\bin\\make.exe)" \
    -DBUILD_TOOLS="$(cygpath -u $BUILD_TOOLS)" \
    -DANDROID_HOME="$(cygpath -u $ANDROID_HOME)" \
    -B./cmake-build && \
    cd cmake-build && \
    cmake --build . 

$BUILD_TOOLS/aapt package -f \
    -M $current_directory/android/AndroidManifest.xml \
    -S $current_directory/android/res \
    -I $ANDROID_HOME/platforms/android-29/android.jar \
    -F $current_directory/cmake-build/NativeActivity.unsigned.apk

# add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/bin/NativeActivity.unsigned.apk
#     COMMAND ${}/
    
#     COMMAND ${BUILD_TOOLS}/aapt add ${CMAKE_BINARY_DIR}/bin/NativeActivity.unsigned.apk ${CMAKE_BINARY_DIR}/libandroidcmakeexample.so
#     DEPENDS ${CMAKE_BINARY_DIR}/libandroidcmakeexample.so
#     WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#     COMMENT "Creating bin/NativeActivity.unsigned.apk.")