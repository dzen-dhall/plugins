#!/usr/bin/env bash
set -e -o pipefail

# Usage:
#
# - To run checks for all plugins:
#
#   ./check.sh
#
# - To check a single plugin:
#
#   ./check.sh plugin-name
#
# - To check and run a single plugin:
#
#   ./check.sh plugin-name run
#

selected="$1"
shouldRun="$2"

if [[ "$selected" == "" ]]; then
    dirs=`find ./ -type d -regextype posix-extended -regex '^./[a-z0-9-]+$'`;
else
    dirs="./$selected"
fi;

# Note to self: when making changes make sure that this script remains safe,
# i.e. running it can't result in execution of code from plugin files.
# We don't store any credentials for `plugin` repo in CI variables, but people
# may want to run this script on their PCs, and for reproducibility we must
# keep plugins' code away.

function error {
    echo "$1"
    exit 1
}


echo "$dirs" | while read dir; do
    tmpDir=`mktemp -d`
    configDir="$tmpDir/config"
    pluginFile="$dir/plugin.dhall"
    demoFile="$dir/demo.dhall"
    pluginName=`echo "$dir" | awk '{split($0,a,"/"); print a[2]}'`

    echo ""
    echo "------------- Checking $pluginName -------------------";
    echo ""

    if [ ! -r "$pluginFile" ]; then
        error "$pluginFile does not exist! All plugin directories must contain a plugin.dhall";
    fi;

    if [[ ! "$pluginName" =~ ^[a-z0-9-]+$ ]]; then
        error "Invalid plugin name: $pluginName, must match [a-z0-9-]+"
    fi;

    if [ ! -r "$demoFile" ]; then
        error "$demoFile does not exist! All plugin directories must contain a demo.dhall";
    fi;

    # Check if `demo.dhall` imports the plugin.
    noImportMessage=$(cat <<-EOF
	$demoFile does not reference ./plugins/$pluginName.dhall: perhaps you forgot to update it.

	\`demo.dhall\` files are used to show how a plugin can be used.
	EOF
    )

    grep "./plugins/$pluginName.dhall" "$demoFile" &>/dev/null || error "$noImportMessage"

    # Plug the plugin file, put `demo.dhall` in place of a `config.dhall` and run
    # `dzen-dhall validate`.

    dzen-dhall --config-dir "$configDir" init &>/dev/null
    dzen-dhall --config-dir "$configDir" plug --yes "$pluginFile"
    cp "$demoFile" "$configDir/config.dhall"
    dzen-dhall --config-dir "$configDir" validate

    # Run a plugin passed as the first argument.
    if [[ "$shouldRun" == "run" ]]; then
        dzen-dhall --config-dir "$configDir"
    fi;

    # Check that the plugin does not contain URL imports.
    # However, we do not want to ban URLs in comments and strings.
    # So we just replace all URLs with garbage and check if `dzen-dhall` complains.
    # If it does, then it's certainly because of URL imports in dhall: we
    # don't even reach the stage when string contents start matter when running
    # `dzen-dhall validate`.

    sed -i -e 's!http[s]\?://[a-zA-Z0-9]*!!g' "$configDir/plugins/$pluginName.dhall"
    sed -i -e 's!http[s]\?://[a-zA-Z0-9]*!!g' "$configDir/config.dhall"

    dzen-dhall --config-dir "$configDir" validate &>/dev/null ||
        (echo "Plugin $pluginName contains URL imports!" && exit 1);

    # We don't want to require existing readme section during development,
    # however, CI must be able to verify that it exists.

    if [[ "" == `cat ./README.md | grep "## $pluginName"` && "$CI" != "" ]]; then
        error "No README section found for plugin $pluginName. You should add this plugin to the catalogue."
    fi;

done;

# Check that ordering of sections in README is correct
sections=`cat README.md | sed "0,/Catalogue/d" | grep '## [a-z0-9-]\+'`
sorted=`echo "$sections" | sort`
unsortedError=$(cat <<EOF
Catalogue sections in README.md must be sorted.
Expected:

$sorted

Got:

$sections
EOF
)

if [[ "$sections" != "$sorted" ]]; then
    error "$unsortedError";
fi;

echo "Success!"
