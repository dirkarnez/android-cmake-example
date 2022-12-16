export USERPROFILE=/C/Users/19081126D

export current_directory=$(PWD)

# export ANDROID_HOME=$USERPROFILE/Downloads/PORTABLE_ANDROID_HOME
# export PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
# export PATH=$ANDROID_HOME/emulator/:$PATH
# export PATH=$ANDROID_HOME/platform-tools/:$PATH

export ANDROID_NDK_HOME=$USERPROFILE/Downloads/PORTABLE_ANDROID_HOME/ndk/25.1.8937393
# export ANDROID_NDK=$USERPROFILE/android-ndk-r25b-windows/android-ndk-r25b

# export ANDROID_CMAKE_HOME=$current_directory/android-cmake

export PATH=$USERPROFILE/Downloads/cmake-3.22.2-windows-x86_64/bin:$PATH



# sdkmanager.bat --list

#sdkmanager.bat --install "platform-tools" "platforms;android-29" "build-tools;29.0.2" "ndk;25.1.8937393"

# cd $ANDROID_CMAKE_HOME && \
# ls && \
# cd $current_directory && \
# ls && \
export ANDROID_HOME=$USERPROFILE/Downloads/PORTABLE_ANDROID_HOME
# ANDROID_NDK C:\Users\19081126D\Downloads\PORTABLE_ANDROID_HOME\ndk\25.1.8937393
export BUILD_TOOLS=$ANDROID_HOME/build-tools/29.0.2


echo $ANDROID_NDK_HOME && \
cmake.exe -G"MinGW Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE="$USERPROFILE/Downloads/PORTABLE_ANDROID_HOME/ndk/25.1.8937393/build/cmake/android.toolchain.cmake" \
    -DCMAKE_MAKE_PROGRAM="$USERPROFILE/Downloads/PORTABLE_ANDROID_HOME/ndk/25.1.8937393/prebuilt/windows-x86_64/bin/make.exe" \
    -DBUILD_TOOLS="$BUILD_TOOLS" \
    -DANDROID_HOME="$ANDROID_HOME" \
    -B./cmake-build && \
    cd cmake-build && \
    cmake --build . 


# set(TOOLCHAIN "/home/amon/software/android/native-toolchain")
# set( "/home/amon/software/android")
# set( "/home/amon/software/android/build-tools/25.0.3")
# set( "/home/amon/software/android/ndk/ndk-r14b")
# set(JAVA_HOME $ENV{JAVA_HOME})

# C:\Users\19081126D\Downloads\PORTABLE_ANDROID_HOME\ndk\25.1.8937393\toolchains\llvm\prebuilt\windows-x86_64
