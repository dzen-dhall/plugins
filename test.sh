#!/usr/bin/env bash

# Note to self: when making changes make sure that this script can't result in
# code execution when run on CI.
# We don't store any credentials for `plugin` repo in CI variables, but still.

set -e -o pipefail

function error {
    echo "$1"
    exit 1
}

for dir in ./*/; do

    tmpDir=`mktemp -d`
    configDir="$tmpDir/configs"
    pluginFile="$dir""plugin.dhall"
    demoFile="$dir""demo.dhall"
    pluginName=`echo "$dir" | awk '{split($0,a,"/"); print a[2]}'`

    echo ""
    echo "------------- Testing $pluginName -------------------";
    echo ""

    if [ ! -r "$pluginFile" ]; then
        error "$pluginFile does not exist! All plugin directories must contain a plugin.dhall";
    fi;

    if [[ ! $pluginName =~ ^[a-z0-9-]+$ ]]; then
        error "Invalid plugin name: $pluginName"
    fi;

    if [ ! -r "$demoFile" ]; then
        error "$demoFile does not exist! All plugin directories must contain a demo.dhall";
    fi;

    dzen-dhall --config-dir "$configDir" init &>/dev/null
    dzen-dhall --config-dir "$configDir" plug --yes "$dir/plugin.dhall"
    cp "$demoFile" "$configDir/plugins/"
    dzen-dhall --config-dir "$configDir" validate

    if [[ "" == `cat ./README.md | grep "## $pluginName"` ]]; then
        error "No README section found for plugin $pluginName."
    fi;

    if [[ "" == `cat ./README.md | grep "dzen-dhall plug $pluginName"` ]]; then
        error "No installation instructions found in README for plugin $pluginName. Please put \`dzen-dhall plug $pluginName\` to README.md"
    fi;
done;

echo "Success!"
