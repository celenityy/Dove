#!/usr/bin/env bash

# Where Phoenix is located
if [ -z ${phoenix_dir+x} ]; then 
    # default value if unset
    export phoenix_dir=~/Projects/Phoenix
fi

# Version of Dove you'd like to build
export dove_version=2025.03.17.1
