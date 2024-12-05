#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located
cat ~/Projects/Phoenix/configs/Hardened/hardened.cfg dove-spec.cfg > base.cfg

cp base.cfg manual/dove.cfg