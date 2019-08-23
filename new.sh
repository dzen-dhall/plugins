#!/usr/bin/env bash
set -e -o pipefail

pluginName="$1"

function error {
    echo "$1"
    exit 1
}

if [[ -z "$pluginName" ]]; then
    error "You should specify plugin name as argument."
fi;

if [[ ! "$pluginName" =~ ^[a-z0-9-]+$ ]]; then
    error "Invalid plugin name: $pluginName, must match [a-z0-9-]+"
fi;

if [ -e "$pluginName" ]; then
    error "Already exists: $pluginName"
fi;

cp -r plugin-template "$pluginName"

sed -i "s#plugin-template#$pluginName#g" ./"$pluginName"/demo.dhall
sed -i "s#plugin-template#$pluginName#g" ./"$pluginName"/plugin.dhall

echo "Success! Now edit $pluginName/plugin.dhall and $pluginName/demo.dhall"
