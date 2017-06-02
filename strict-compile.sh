#!/bin/bash

$(npm bin)/ddtsc --files "$(git diff --cached --name-only | grep -E '\.ts$')"