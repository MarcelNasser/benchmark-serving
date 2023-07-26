#!/usr/bin/env bash

firefox --version || exit 1

root_dir="$(realpath "$(dirname "$0")")"

find "$root_dir/reports" -name '*.html' | \
  xargs -I % bash -c "cd \$root_dir; file=%; echo converting .. \$file; firefox --headless  --screenshot file:///\$root_dir\$file 2>/dev/null; mv screenshot.png \${file//.html/.png}"

