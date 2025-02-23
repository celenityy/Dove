#!/bin/bash

source build/env.sh

./build/gen_dove.sh && ./build/gen_macos.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
