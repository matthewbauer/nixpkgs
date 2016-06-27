xcbuildPhase() {
    runHook preConfigure

    echo "running xcodebuild"

    xcodebuild -verbose DERIVED_DATA_DIR=$(pwd)/DerivedData/ OTHER_CFLAGS="$NIX_CFLAGS_COMPILE -fno-modules -fno-objc-arc"

    runHook postConfigure
}

if [ -d "*.xcodeproj" ]; then
    buildPhase=xcbuildPhase
fi
