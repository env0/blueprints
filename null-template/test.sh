#!/usr/bin/env bash
set -e

JSON_OUTPUT=$(curl 'https://api.github.com/')
echo ${JSON_OUTPUT}
KEY=$(curl 'https://api.github.com/' | npx jq.node 'get("authorizations_url") | toString')
echo ${KEY}