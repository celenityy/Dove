#!/bin/bash
set -euo pipefail
exec "${DOVE_BASH}" -c "echo $@" || exit 1
