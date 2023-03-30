#!/usr/bin/env bash
source setup.inc.sh

function check_requirements {
  echo "Checking existence of required binaries: $REQUIREMENTS"
  NOTFOUND=false

  for i in $REQUIREMENTS; do
    which $i > /dev/null && echo "$i found" || { echo "$i not found in PATH"; NOTFOUND=true; }
  done

  if [[ "$NOTFOUND" == "true" ]]; then
    echo "Please install and/or add unmet requirements to the PATH variable and try again"
    exit 1
  else
    echo "All requirements met"
  fi
}

# Run function to check requirements
check_requirements
