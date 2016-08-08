source $stdenv/setup

preConfigure() {
    . $GNUSTEP_MAKEFILES/GNUstep.sh
}

wrapGSMake() {
    local program="$1"
    local config="$2"
    local wrapped="$(dirname $program)/.$(basename $program)-wrapped"

    mv "$program" "$wrapped"

    cat > "$program"<<EOF
#! $SHELL -e

export GNUSTEP_CONFIG_FILE="$config"

exec "$wrapped" "\$@" "\${extraFlagsArray[@]}"
EOF
    chmod +x "$program"
}

postInstall() {
    local conf="$out/share/.GNUstep.conf"

    mkdir -p "$out/share"
    touch $conf

    # add the current package to the paths
    local tmp="$out/lib/GNUstep/Applications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_APPS "$tmp"
    fi
    tmp="$out/lib/GNUstep/Applications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_ADMIN_APPS "$tmp"
    fi
    tmp="$out/lib/GNUstep/WebApplications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_WEB_APPS "$tmp"
    fi
    tmp="$out/bin"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_TOOLS "$tmp"
    fi
    tmp="$out/sbin"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_ADMIN_TOOLS "$tmp"
    fi
    tmp="$out/lib/GNUstep"
    if [ -d "$tmp" ]; then
    	addToSearchPath NIX_GNUSTEP_SYSTEM_LIBRARY "$tmp"
    fi
    tmp="$out/include"
    if [ -d "$tmp" ]; then
    	export NIX_GNUSTEP_SYSTEM_HEADERS+=" $tmp"
    fi
    tmp="$out/lib"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_LIBRARIES "$tmp"
    fi
    tmp="$out/share/GNUstep/Documentation"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC "$tmp"
    fi
    tmp="$out/share/man"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC_MAN "$tmp"
    fi
    tmp="$out/share/info"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC_INFO "$tmp"
    fi

    # write the config file
    echo GNUSTEP_MAKEFILES=$GNUSTEP_MAKEFILES >> $conf
    if [ -n "$NIX_GNUSTEP_SYSTEM_APPS" ]; then
	echo NIX_GNUSTEP_SYSTEM_APPS="$NIX_GNUSTEP_SYSTEM_APPS"
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_ADMIN_APPS" ]; then
	echo NIX_GNUSTEP_SYSTEM_ADMIN_APPS="$NIX_GNUSTEP_SYSTEM_ADMIN_APPS" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_WEB_APPS" ]; then
	echo NIX_GNUSTEP_SYSTEM_WEB_APPS="$NIX_GNUSTEP_SYSTEM_WEB_APPS" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_TOOLS" ]; then
	echo NIX_GNUSTEP_SYSTEM_TOOLS="$NIX_GNUSTEP_SYSTEM_TOOLS" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_ADMIN_TOOLS" ]; then
	echo NIX_GNUSTEP_SYSTEM_ADMIN_TOOLS="$NIX_GNUSTEP_SYSTEM_ADMIN_TOOLS" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_LIBRARY" ]; then
	echo NIX_GNUSTEP_SYSTEM_LIBRARY="$NIX_GNUSTEP_SYSTEM_LIBRARY" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_HEADERS" ]; then
	echo NIX_GNUSTEP_SYSTEM_HEADERS="$NIX_GNUSTEP_SYSTEM_HEADERS" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_LIBRARIES" ]; then
	echo NIX_GNUSTEP_SYSTEM_LIBRARIES="$NIX_GNUSTEP_SYSTEM_LIBRARIES" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_DOC" ]; then
	echo NIX_GNUSTEP_SYSTEM_DOC="$NIX_GNUSTEP_SYSTEM_DOC" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_DOC_MAN" ]; then
	echo NIX_GNUSTEP_SYSTEM_DOC_MAN="$NIX_GNUSTEP_SYSTEM_DOC_MAN" >> $conf
    fi
    if [ -n "$NIX_GNUSTEP_SYSTEM_DOC_INFO" ]; then
	echo NIX_GNUSTEP_SYSTEM_DOC_INFO="$NIX_GNUSTEP_SYSTEM_DOC_INFO" >> $conf
    fi
    
    for i in $out/bin/*; do
	echo "wrapping $(basename $i)"
	wrapGSMake "$i" "$out/share/.GNUstep.conf"
    done
}

genericBuild
