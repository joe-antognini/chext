#! /bin/bash

installation_path=$(which chext)

# Remove executable
rm $installation_path

# Remove man page
prefix=${installation_path%/*}
rm $prefix/../share/man/man1/chext.1
