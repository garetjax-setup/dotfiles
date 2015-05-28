function normalize_trailing_newlines() {
    # Remove all trailing newlines
    perl -pi -e 'chomp if eof' "$1"

    # Add just a single final one
    sed -i '' -e '$a\' "$1"
}

function remove_trailing_whitespace() {
    sed -i '' -E 's/[[:blank:]]*$//' "$1"
}

function normalize_whitespace() {
    remove_trailing_whitespace "$1"
    normalize_trailing_newlines "$1"
}

function norm_py_whitespace() {
    # XXX: does not work on filenames with spaces
    find . -name \*.py | while read file; do normalize_whitespace "$file"; done
}
