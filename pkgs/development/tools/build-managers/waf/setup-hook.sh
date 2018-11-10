wafConfigurePhase() {
    runHook preConfigure

    if ! [ -f ./waf ]; then
        cp @waf@ waf
    fi

    if [[ -z "${dontAddPrefix:-}" && -n "$prefix" ]]; then
        configureFlags="${prefixKey:---prefix=}$prefix $configureFlags"
    fi

    # Old bash empty array hack
    # shellcheck disable=SC2086
    local flagsArray=(
        $configureFlags ${configureFlagsArray+"${configureFlagsArray[@]}"}
    )
    echoCmd 'configure flags' "${flagsArray[@]}"
    python waf "${flagsArray[@]}" configure

    runHook postConfigure
}

wafBuildPhase () {
    runHook preBuild

    # set to empty if unset
    : ${wafFlags=}

    # Old bash empty array hack
    # shellcheck disable=SC2086
    local flagsArray=(
      ${enableParallelBuilding:+-j ${NIX_BUILD_CORES}}
      $wafFlags ${wafFlagsArray+"${wafFlagsArray[@]}"}
      $buildFlags ${buildFlagsArray+"${buildFlagsArray[@]}"}
    )

    echoCmd 'build flags' "${flagsArray[@]}"
    python waf "${flagsArray[@]}" build

    runHook postBuild
}

wafInstallPhase() {
    runHook preInstall

    if [ -n "$prefix" ]; then
        mkdir -p "$prefix"
    fi

    # Old bash empty array hack
    # shellcheck disable=SC2086
    local flagsArray=(
        $wafFlags ${wafFlagsArray+"${wafFlagsArray[@]}"}
        $installFlags ${installFlagsArray+"${installFlagsArray[@]}"}
    )

    echoCmd 'install flags' "${flagsArray[@]}"
    python waf "${flagsArray[@]}" install

    runHook postInstall
}

configurePhase=wafConfigurePhase
buildPhase=wafBuildPhase
installPhase=wafInstallPhase
