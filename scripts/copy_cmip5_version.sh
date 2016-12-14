#!/bin/bash

# copy_cmip5_version.sh
# ---------------------
#
# Simple script to copy the directory structure and a CMIP5 version dataset
# to the cp4cds1 GWS.
# 
# Copies symlinks as target files so entire symlink structure is removed
# from the new structure used here.
#

version_dset=$1
version=$(basename $version_dset)

if ! [[ $version =~ ^v.+$ ]]; then
    echo "Must provide valid path to version directory as only argument!"
    exit
fi

basedir=/group_workspaces/jasmin/cp4cds1/data/initial
badcdir=/badc/cmip5/data

path=$(dirname $version_dset)

if ! [[ $path =~ ^${badcdir}.+$ ]]; then
    echo "Must provide valid BADC directory path as argument!"
    exit
fi

targetdir=$(echo $version_dset | sed "s|${badcdir}|${basedir}|g")
echo "Copying contents of: $version_dset"
echo "...to...: $targetdir"

mkdir -p $targetdir
cp -rL $version_dset/* $targetdir/
