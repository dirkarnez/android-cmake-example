export current_directory=$(PWD)


export USERPROFILE=$(cygpath -u $USERPROFILE)


export ANDROID_HOME=$USERPROFILE/Downloads/commandlinetools-win-9123335_latest

export PATH=$ANDROID_HOME/cmdline-tools/bin/:$PATH
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH=$USERPROFILE/Downloads/cmake-3.22.2-windows-x86_64/bin:$PATH

export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
export BUILD_TOOLS=$ANDROID_HOME/build-tools/27.0.2

export JAVA_HOME=$USERPROFILE/Downloads/OpenJDK8U-jdk_x64_windows_hotspot_8u322b06/jdk8u322-b06
export PATH=$JAVA_HOME/bin/:$PATH

# export ANDROID_NDK=$USERPROFILE/android-ndk-r25b-windows/android-ndk-r25b

# export ANDROID_CMAKE_HOME=$current_directory/android-cmake


# sdkmanager.bat --list --sdk_root=$ANDROID_HOME
sdkmanager.bat --sdk_root=$ANDROID_HOME --install "platform-tools" "platforms;android-27" "build-tools;27.0.2" "ndk-bundle"



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




# $USERPROFILE/Downloads\commandlinetools-win-9123335_latest\ndk\25.1.8937393\toolchains\llvm\prebuilt\windows-x86_64\bin
echo $ANDROID_NDK_HOME && \
cd $current_directory && \
cmake.exe -G"MinGW Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="${C_FLAGS}" \
    -DCMAKE_TOOLCHAIN_FILE="$(cygpath -u $ANDROID_NDK_HOME\\build\\cmake\\android.toolchain.cmake)" \
    -DCMAKE_MAKE_PROGRAM="$(cygpath -u $ANDROID_NDK_HOME\\prebuilt\\windows-x86_64\\bin\\make.exe)" \
    -DANDROID_ABI="arm64-v8a"  \                             // For example, arm64-v8a
    -DANDROID_PLATFORM="android-27"  \     // For example, android-16
    -DANDROID_STL=c++_static \
    -DCMAKE_ANDROID_ARCH_ABI="arm64-v8a" \
    -DBUILD_TOOLS="$(cygpath -u $BUILD_TOOLS)" \
    -DANDROID_HOME="$(cygpath -u $ANDROID_HOME)" \
    -B./cmake-build && \
    cd cmake-build && \
    cmake --build . && \
\
cd $current_directory && \
mkdir -p ./lib && \
cp ./cmake-build/libandroidcmakeexample.so ./lib/libandroidcmakeexample.so && \
\
$BUILD_TOOLS/aapt package -f -m \
    -S ./android/res \
    -J ./src \
    -M ./android/AndroidManifest.xml \
    -I $ANDROID_HOME/platforms/android-27/android.jar && \
\
cd $current_directory && \
\
mkdir -p obj && \
\
javac \
    -d obj \
    -classpath $ANDROID_HOME/platforms/android-27/android.jar \
    $current_directory/src/com/example/androidcmakeexample/R.java && \
\
cd $current_directory && \
\
mkdir -p bin && \
\
$BUILD_TOOLS/dx.bat --dex --output=bin/classes.dex obj && \
\
$BUILD_TOOLS/aapt package -f \
    -M ./android/AndroidManifest.xml \
    -S ./android/res \
    -I $ANDROID_HOME/platforms/android-27/android.jar \
    -F ./bin/NativeActivity.unsigned.apk bin && \
\
$BUILD_TOOLS/aapt add ./bin/NativeActivity.unsigned.apk ./lib/libandroidcmakeexample.so