#!/usr/bin/env bash

gh api --paginate /repos/fish-shell/fish-shell/releases >fish-releases.json
jq '[.[] | select(.assets | length > 0) | select(.prerelease | not) | {tag: .tag_name, file: .assets | .[] | .name | select(endswith(".tar.gz") or endswith(".tar.xz"))}]' fish-releases.json >fish-releases-filtered.json
