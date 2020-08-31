#!/bin/bash

# Check bash, (how do you even run this script without it ??)
if ! command -v bash &> /dev/null
then
    echo "It appears you do not have bash in your PATH, but it is required to generate the specfile."
    exit 1
fi

# Check git
if ! command -v git &> /dev/null
then
    echo "It appears you do not have git in your PATH, but it is required to generate the specfile."
    exit 1
fi

# Check osc
if ! command -v osc &> /dev/null
then
    echo "It appears you do not have osc in your PATH, but it is required to generate the specfile."
    exit 1
fi

# Check bzip2
if ! command -v bzip2 &> /dev/null
then
    echo "It appears you do not have bzip2 in your PATH, but it is required to generate the specfile."
    exit 1
fi

# Check GNU patch
if ! command -v patch &> /dev/null
then
    echo "It appears you do not have patch in your PATH, but it is required to generate the specfile."
    exit 1
fi
