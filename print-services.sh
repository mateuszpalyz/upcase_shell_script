#!/bin/sh

set -e
set -o pipefail

if [ $# -eq 0 ]; then
  echo "Services directory missing"
  exit 64
fi

print_services() {
  if grep -q port "$1" && grep -q name "$1"; then
    name=$(grep name "$1" | sed 's/name //')
    port=$(grep port "$1" | sed 's/port //')

    if [ -f "$1" ]; then
      echo "$1 is a file"
    fi

    echo "In $1 we're running $name on $port"
  else
    echo "$1 does not have a port or a name"
  fi
}

for file in "$1"/*.service; do
  print_services "$file"
done
