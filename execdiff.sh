#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
DATA_DIR="$SCRIPT_DIR"

record_executables() {
    local output_file="$1"
    find /c/test -type f \( -iname "*.exe" -o -iname "*.bat" -o -iname "*.cmd" -o -iname "*.com" \) | sort > "$output_file"
}

case "$1" in
    --before)
        record_executables "$DATA_DIR/before.txt"
        ;;
    --after)
        record_executables "$DATA_DIR/after.txt"
        ;;
    --compare)
        diff -u "$DATA_DIR/before.txt" "$DATA_DIR/after.txt" > "$DATA_DIR/diff.patch"
        cat "$DATA_DIR/diff.patch"
        ;;
    *)
        echo "Usage: $0 --before | --after | --compare"
        exit 1
        ;;
esac
