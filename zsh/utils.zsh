function normalize_trailing_newlines() {
    # Remove all trailing newlines
    perl -pi -e 'chomp if eof' "$1"

    # Add just a single final one
    LC_CTYPE=C sed -i '' -e '$a\' "$1"
}

function remove_trailing_whitespace() {
    LC_CTYPE=C sed -i '' -E 's/[[:blank:]]*$//' "$1"
}

function normalize_whitespace() {
    remove_trailing_whitespace "$1"
    normalize_trailing_newlines "$1"
}

function norm_py_whitespace() {
    # XXX: does not work on filenames with spaces
    find . -name \*.py | while read file ; do normalize_whitespace "$file"; done
}

function burn_iso_to_usb() {
    ISO="$1"
    IMG="${ISO}.dmg"
    DISK="$2"
    hdiutil convert -format UDRW -o "$IMG" "$ISO"
    diskutil unmountDisk "$DISK"
    pv -par "$IMG" | sudo dd of="$DISK" bs=1m
    rm "$IMG"
    diskutil eject "$DISK"
}

function cpkey() {
    curl -s "https://github.com/${1}.keys" | pbcopy
}
