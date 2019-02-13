export NIX_SET_BUILD_ID=1
export NIX_CFLAGS_COMPILE+=" -g"
dontStrip=1

fixupOutputHooks+=(_separateDebugInfo)

_separateDebugInfo() {
    [ -e "$prefix" ] || return 0

    local dst="${debug:-$out}"
    if [ "$prefix" = "$dst" ]; then return 0; fi

    dst="$dst/lib/debug/.build-id"

    # Find executables and dynamic libraries.
    local i
    while IFS= read -r -d $'\0' i; do
        if isELF "$i"; then

            # Extract the Build ID. FIXME: there's probably a cleaner way.
            local id="$($READELF -n "$i" | sed 's/.*Build ID: \([0-9a-f]*\).*/\1/; t; d')"
            if [ "${#id}" != 40 ]; then
                echo "could not find build ID of $i, skipping" >&2
                continue
            fi

            # Extract the debug info.
            header "separating debug info from $i (build ID $id)"
            mkdir -p "$dst/${id:0:2}"
            $OBJCOPY --only-keep-debug "$i" "$dst/${id:0:2}/${id:2}.debug"
            $STRIP --strip-debug "$i"

            # Also a create a symlink <original-name>.debug.
            ln -sfn ".build-id/${id:0:2}/${id:2}.debug" "$dst/../$(basename "$i")"

        elif isMachO "$i"; then

            local id="$(llvm-dwarfdump -uuid "$i" | sed 's/UUID: \([0-9A-F-]*\) .*/\1/' | tr '[:upper:]' '[:lower:]' | tr -d -)"
            if [ "${#id}" != 32 ]; then
                echo "could not find build ID of $i, skipping" >&2
                continue
            fi

            # Extract the debug info.
            header "separating debug info from $i (build ID $id)"
            dsymutil -flat -o "$dst/${id:0:2}/${id:2}.debug" "$i"
            $STRIP --strip-debug "$i"

            # Also a create a symlink <original-name>.debug.
            ln -sfn ".build-id/${id:0:2}/${id:2}.dwarf" "$dst/../$(basename "$i")"

        fi
    done < <(find "$prefix" -type f -print0)
}
