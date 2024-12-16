#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located
cat ~/Projects/Phoenix/phoenix.cfg ~/Projects/Phoenix/configs/hardened.cfg build/configs/dove-spec.cfg > dove.cfg
