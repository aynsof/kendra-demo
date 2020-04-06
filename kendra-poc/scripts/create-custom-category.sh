#!/bin/bash

if [ $# -eq 1 ]
then
    CAT_NAME="$1"
    CAT_TYPE="STRING_VALUE"
elif [ $# -eq 2 ]
then
    CAT_NAME="$1"
    CAT_TYPE="$2"
else
    echo "usage $0 <category_name> [category_type:STRING_VALUE|STRING_LIST_VALUE|LONG_VALUE|DATE_VALUE]" >&2
    exit 1
fi

aws kendra update-index --id "10c7ac35-6c65-48f0-9c03-5bfcf58d288d" --document-metadata-configuration-updates '
[
  {
    "Name": "'"$CAT_NAME"'",
    "Type": "'"$CAT_TYPE"'",
    "Search": {
      "Facetable": true,
      "Searchable": true,
      "Displayable": true
    }
  }
]'