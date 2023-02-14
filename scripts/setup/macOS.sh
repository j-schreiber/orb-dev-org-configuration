#! /bin/bash
set -e

alias='OrbDeveloperOrg'
duration=7
configFile='config/default-scratch-def.json'
devhubusername=

while getopts a:d:f:v: option
do
    case "${option}" in
        a )             alias=${OPTARG};;
        d )             duration=${OPTARG};;
        f )             configFile=${OPTARG};;
        v )             devhubusername=${OPTARG};;
        * )
    esac
done

KEYS=scripts/.config/keys.env
if [ -f "$KEYS" ]; then
    set -o allexport
    source scripts/.config/keys.env
    set +o allexport
fi

echo "npm ci"
npm ci

if [ -z "$devhubusername" ]; then
    echo "sfdx force:org:create -d $duration -f $configFile -a $alias -s"
    sfdx force:org:create -d $duration -f $configFile -a $alias -s
else
    echo "sfdx force:org:create -v $devhubusername -d $duration -f $configFile -a $alias -s"
    sfdx force:org:create -v $devhubusername -d $duration -f $configFile -a $alias -s
fi

echo "sfdx force:source:deploy -u $alias -p src/deploy"
sfdx force:source:deploy -u $alias -p src/deploy

echo "sfdx force:org:open -u $alias"
sfdx force:org:open -u $alias
