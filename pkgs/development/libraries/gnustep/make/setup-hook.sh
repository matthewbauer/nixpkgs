# this path is used by some packages to install additional makefiles
export DESTDIR_GNUSTEP_MAKEFILES=$out/share/GNUstep/Makefiles

installFlagsArray=( \
  "GNUSTEP_INSTALLATION_DOMAIN=SYSTEM" \
  "GNUSTEP_SYSTEM_APPS=$out/lib/GNUstep/Applications" \
  "GNUSTEP_SYSTEM_ADMIN_APPS=$out/lib/GNUstep/Applications" \
  "GNUSTEP_SYSTEM_WEB_APPS=$out/lib/GNUstep/WebApplications" \
  "GNUSTEP_SYSTEM_TOOLS=$out/bin" \
  "GNUSTEP_SYSTEM_ADMIN_TOOLS=$out/sbin" \
  "GNUSTEP_SYSTEM_LIBRARY=$out/lib/GNUstep" \
  "GNUSTEP_SYSTEM_HEADERS=$out/include" \
  "GNUSTEP_SYSTEM_LIBRARIES=$out/lib" \
  "GNUSTEP_SYSTEM_DOC=$out/share/GNUstep/Documentation" \
  "GNUSTEP_SYSTEM_DOC_MAN=$out/share/man" \
  "GNUSTEP_SYSTEM_DOC_INFO=$out/share/info" \
)

addEnvVars() {
    local filename

    for filename in $1/share/GNUstep/Makefiles/Additional/*.make ; do
	export NIX_GNUSTEP_MAKEFILES_ADDITIONAL+=" $filename"
    done

    local tmp="$1/lib/GNUstep/Applications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_APPS "$tmp"
    fi
    tmp="$1/lib/GNUstep/Applications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_ADMIN_APPS "$tmp"
    fi
    tmp="$1/lib/GNUstep/WebApplications"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_WEB_APPS "$tmp"
    fi
    tmp="$1/bin"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_TOOLS "$tmp"
    fi
    tmp="$1/sbin"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_ADMIN_TOOLS "$tmp"
    fi
    tmp="$1/lib/GNUstep"
    if [ -d "$tmp" ]; then
    	addToSearchPath NIX_GNUSTEP_SYSTEM_LIBRARY "$tmp"
    fi
    tmp="$1/include"
    if [ -d "$tmp" ]; then
    	export NIX_GNUSTEP_SYSTEM_HEADERS+=" $tmp"
    fi
    tmp="$1/lib"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_LIBRARIES "$tmp"
    fi
    tmp="$1/share/GNUstep/Documentation"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC "$tmp"
    fi
    tmp="$1/share/man"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC_MAN "$tmp"
    fi
    tmp="$1/share/info"
    if [ -d "$tmp" ]; then
	addToSearchPath NIX_GNUSTEP_SYSTEM_DOC_INFO "$tmp"
    fi
}
envHooks=(${envHooks[@]} addEnvVars)
