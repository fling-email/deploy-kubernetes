#!/bin/bash

# Script to compile and output the full service yml for a folder

if [ $# -ne 2 ]; then
    echo "Usage: $0 variables.json path/to/folder"
    exit 1
fi

# Store friendly variables of input params
# Also strip trailing slash from folder path
variables_file_path=$1
yml_dir_path=${2%/}

if [[ "$yml_dir_path" = "" || ! -d $yml_dir_path ]]; then

    echo "Yaml dir path does not exist"
    exit 1

fi

if [[ "$variables_file_path" = "" || ! -f $variables_file_path ]]; then

    echo "Variables file does not exist"
    exit 1

fi

for file in "$yml_dir_path"/*.yml; do

    # Compile the template and write to the file
    docker run \
        --rm \
        --network none \
        -v "$(pwd):/data" \
        dinutac/jinja2docker:2.1.5 \
        "/data/$file" \
        "/data/$variables_file_path" \
        --format=json \

    # write a seperator between each compiled template
    echo ""
    echo "---"
    echo ""

done
