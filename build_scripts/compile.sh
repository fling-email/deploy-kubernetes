#!/bin/bash

# Script to compile all services into a single yml file to be deployed

# Needed for ** for work in the for loop.
shopt -s globstar

variables_file_path="variables.json"

if [ ! -f $variables_file_path ]; then
    echo "Variables file not found"
    exit 1
fi

mkdir -p dist
rm -f dist/*.yml

echo "Updating deployment"

# Loop over all our service yml files
for template_path in services/**/*.yml; do

    compiled_path="dist/${template_path//\//_}"

    echo "Compiling ${template_path} to ${compiled_path}"

    # Compile and output each template
    docker run \
        --rm \
        --network none \
        -v "$(pwd):/data" \
        dinutac/jinja2docker:2.1.6 \
        "/data/$template_path" \
        "/data/$variables_file_path" \
        --format=json \
        >> $compiled_path

    if [ $? -ne 0 ]; then
        echo "Error during template compilation"
        exit $?
    fi

done
