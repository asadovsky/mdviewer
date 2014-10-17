#!/bin/bash

set -e
set -u

main() {
  local -r OUTFILE="$(pwd)/marked.min.js"
  curl -L http://cdnjs.cloudflare.com/ajax/libs/marked/0.3.2/marked.min.js -o "${OUTFILE}"
  echo "Wrote ${OUTFILE}"
}

main "$@"
