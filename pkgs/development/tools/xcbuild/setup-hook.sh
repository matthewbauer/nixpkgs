xcbuildPhase() {
    runHook preConfigure

    echo "running xcodebuild"

    xcodebuild DERIVED_DATA_DIR=$(pwd)/DerivedData/ OTHER_CFLAGS="$NIX_CFLAGS_COMPILE"

    runHook postConfigure
}

if [ -z "$configurePhase" ]; then
    configurePhase=xcbuildPhase
fi

echo 'configuring...'
