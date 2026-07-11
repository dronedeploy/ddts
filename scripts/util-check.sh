#!/bin/bash

ACCEPTED_UTIL_EXTENSION="-utils.ts"
BANNED_UTIL_EXTENSIONS=("-util.ts" ".util.ts" ".utils.ts" ".utility.ts" "-utility.ts" ".utilities.ts" "-utilities.ts")
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
NO_COLOR="\033[0m"

check_for_banned_name() {
    local file="$1"
    for banned_extension in "${BANNED_UTIL_EXTENSIONS[@]}"; do
        if [[ "$file" == *"$banned_extension" ]]; then
            echo "$file"
            return 0
        fi
    done
    return 1
}

main() {
    if [ $# -eq 0 ]; then
        echo "No files provided for checking."
        exit 0
    fi

    local invalid_files=()

    for file in "$@"; do
        if invalid_file=$(check_for_banned_name "$file"); then
            invalid_files+=("$invalid_file")
        fi
    done

    if [ ${#invalid_files[@]} -ne 0 ]; then
        printf "\nUtility files should end with %s\"%s\"%s\n\n" "$GREEN" "$ACCEPTED_UTIL_EXTENSION" "$NO_COLOR"
        printf "Files to rename:\n================\n"
        for file in "${invalid_files[@]}"; do
            printf "%s%s%s\n" "$YELLOW" "$file" "$NO_COLOR"
        done
        printf "\n"
        exit 1
    fi

    exit 0
}

main "$@"
