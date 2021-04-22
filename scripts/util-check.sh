#!/bin/sh

# Ensures that utility files end with -utils.ts

accepted_util_extension="-utils.ts"
banned_util_extensions=("-util.ts" ".util.ts" ".utils.ts" ".utility.ts" "-utility.ts" ".utilities.ts" "-utilities.ts")
changed_files=$@
invalid_files=()

yellow="\033[0;33m"
no_color="\033[0m"

function check_for_banned_name() {
    changed_file=$1
    for i in "${banned_util_extensions[@]}"
    do
        banned_util_extension=$i
        if [[ $changed_file == *$banned_util_extension ]]
        then
            invalid_files=(${arrVar1[@]} $changed_file)
        fi
    done
}

for changed_file in ${changed_files}
do
  check_for_banned_name $changed_file
done

if [ ${#invalid_files[@]} -ne 0 ]
then   
    printf "\nUtility classes should end with \"$accepted_util_extension\"\n\n"
    printf "Files to rename:\n================\n"
    for invalid_file in ${invalid_files}
    do
        printf "$yellow$invalid_file\n"
    done
    printf "$no_color\n"
    exit 1
fi

exit 0
