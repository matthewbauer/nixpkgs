xcbuildPhase() {
    runHook preConfigure

    echo "running xcodebuild"

    xcodebuild DERIVED_DATA_DIR=$(pwd)/DerivedData/ OTHER_CFLAGS="$NIX_CFLAGS_COMPILE -fno-modules -fno-objc-arc"

    runHook postConfigure
}

if [ -z "$configurePhase" ]; then
    configurePhase=xcbuildPhase
fi

echo 'configuring...'
