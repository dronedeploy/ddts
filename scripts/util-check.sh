#!/bin/sh

# Ensures that utility files end with -utils.ts

accepted_util_extension="-utils.ts"
banned_util_extensions=("-util.ts" ".util.ts" ".utils.ts" ".utility.ts" "-utility.ts" ".utilities.ts" "-utilities.ts")
changed_files=$@

echo "Checking utils"

function is_banned_name() {
    changed_file=$1
    for i in "${banned_util_extensions[@]}"
    do
        banned_util_extension=$i
        if [[ $changed_file == *$banned_util_extension ]]
        then
            echo "\"$changed_file\" should end with \"$accepted_util_extension\""
        fi
    done
}


for changed_file in ${changed_files}
do
  is_banned_name $changed_file
done

exit 0