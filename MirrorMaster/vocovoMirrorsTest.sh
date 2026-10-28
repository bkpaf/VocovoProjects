#!/bin/bash

REPORT="/Users/peterfynn/vocovopf/debianSourcesTests/mirror-test-report.txt"
TEMP_SOURCE="/etc/apt/sources.list.d/test-mirror.list"

echo "Mirror Test Report - $(date)" > "$REPORT"
echo "============================================================" >> "$REPORT"

# ---------------------------------------------------------------
# Helper function: tests a single source line and appends result
# ---------------------------------------------------------------
test_mirror() {
  local description="$1"
  local source_line="$2"

  echo "  $description" >> "$REPORT"
  echo "  Source : $source_line" >> "$REPORT"

  echo "$source_line" > "$TEMP_SOURCE"

  if apt-get update -o Dir::Etc::sourcelist="$TEMP_SOURCE" 2>&1 | grep -q "Hit\|Get"; then
    echo "  Result : ✓ PASSED" >> "$REPORT"
  else
    echo "  Result : ✗ FAILED" >> "$REPORT"
  fi

  echo "" >> "$REPORT"
}

# ---------------------------------------------------------------
# BOOKWORM
# ---------------------------------------------------------------
echo "" >> "$REPORT"
echo "[ BOOKWORM ]" >> "$REPORT"
echo "------------------------------------------------------------" >> "$REPORT"

test_mirror "Main Debian"         "deb https://deb.uk.vocovo.com/debian bookworm main contrib non-free-firmware non-free"
test_mirror "Bookworm Updates"    "deb https://deb.uk.vocovo.com/debian bookworm-updates main contrib non-free-firmware non-free"
test_mirror "Bookworm Backports"  "deb https://deb.uk.vocovo.com/debian bookworm-backports main contrib non-free-firmware non-free"
test_mirror "Security"            "deb https://deb.uk.vocovo.com/debian-security bookworm-security main contrib non-free-firmware non-free"
test_mirror "VoCoVo Packages"     "deb [trusted=yes] https://deb.uk.vocovo.com/apt-repo/debian-bookworm/ bookworm main"
test_mirror "Mender"              "deb [arch=amd64] https://deb.uk.vocovo.com/mender debian/bookworm/stable main"
test_mirror "Ngrok (bullseye)"    "deb [arch=amd64] https://deb.uk.vocovo.com/ngrok bullseye main"
test_mirror "NodeJS"              "deb https://deb.uk.vocovo.com/nodesource/ bookworm main"
test_mirror "Yarn"                "deb https://deb.uk.vocovo.com/yarnpkg/ stable main"
test_mirror "Docker"              "deb https://deb.uk.vocovo.com/docker/ bookworm stable"

# ---------------------------------------------------------------
# BUSTER
# ---------------------------------------------------------------
echo "" >> "$REPORT"
echo "[ BUSTER ]" >> "$REPORT"
echo "------------------------------------------------------------" >> "$REPORT"

test_mirror "Main Debian"         "deb https://deb.uk.vocovo.com/debian buster main contrib non-free"
test_mirror "Buster Updates"      "deb https://deb.uk.vocovo.com/debian buster-updates main contrib non-free"
test_mirror "Buster Backports"    "deb https://deb.uk.vocovo.com/debian-archive buster-backports main contrib non-free"
test_mirror "Security"            "deb https://deb.uk.vocovo.com/debian-security buster/updates main contrib non-free"
test_mirror "Mender"              "deb [arch=amd64] https://deb.uk.vocovo.com/mender debian/buster/stable main"
test_mirror "Ngrok"               "deb [arch=amd64] https://deb.uk.vocovo.com/ngrok buster main"
test_mirror "NodeJS"              "deb https://deb.uk.vocovo.com/nodesource/ buster main"
test_mirror "Yarn"                "deb https://deb.uk.vocovo.com/yarnpkg/ stable main"
test_mirror "Docker"              "deb https://deb.uk.vocovo.com/docker/ buster stable"

# ---------------------------------------------------------------
# JESSIE
# ---------------------------------------------------------------
echo "" >> "$REPORT"
echo "[ JESSIE ]" >> "$REPORT"
echo "------------------------------------------------------------" >> "$REPORT"

test_mirror "Main Debian (archive)"     "deb https://deb.uk.vocovo.com/debian-archive jessie main contrib non-free"
test_mirror "Jessie Backports (archive)" "deb https://deb.uk.vocovo.com/debian-archive jessie-backports main contrib non-free"
test_mirror "Security (archive)"        "deb https://deb.uk.vocovo.com/debian-archive-security jessie/updates main contrib non-free"
test_mirror "NodeJS"                    "deb https://deb.uk.vocovo.com/nodesource/ jessie main"

# ---------------------------------------------------------------
# Cleanup
# ---------------------------------------------------------------
rm -f "$TEMP_SOURCE"

echo "============================================================" >> "$REPORT"
echo "Test complete." >> "$REPORT"

echo "Report saved to $REPORT"