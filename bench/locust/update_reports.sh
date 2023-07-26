#!/usr/bin/env bash

firefox --version || exit 1

find ./reports -name '*.html' | xargs -I % bash -c "file=%; firefox --headless  --screenshot \$file; mv screenshot.png ./reports  "