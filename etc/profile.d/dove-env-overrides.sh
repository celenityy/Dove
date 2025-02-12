#!/bin/sh

#
# Copyright (C) 2024-2025 celenity
#
# This file is part of Dove.
#
# Dove is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#
# Dove is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with Dove. If not, see https://www.gnu.org/licenses/.
#

# Environment variables for GNU/Linux distros that further harden Thunderbird for Dove

# Enable Wayland
export MOZ_ENABLE_WAYLAND=1;

# Disable Crash Reporting
export MOZ_CRASHREPORTER_NO_REPORT=1;
export MOZ_CRASHREPORTER_URL="";
export MOZ_CRASHREPORTER_DISABLE=1;
export MOZ_CRASHREPORTER_AUTO_SUBMIT=0;
export MOZ_CRASHREPORTER=0;

# Disable Telemetry
export MOZ_SERVICES_HEALTHREPORT=0;
export MOZ_NORMANDY=0;
export MOZ_TELEMETRY_REPORTING=0;
export MOZ_ASAN_REPORTER=0;
export MOZ_GLEAN_ANDROID=0;

# Misc.
export MOZ_REQUIRE_SIGNING=1;
export MOZ_DISABLE_PARENTAL_CONTROLS=1;
