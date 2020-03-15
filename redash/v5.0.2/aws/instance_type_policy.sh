#!/usr/bin/env bash

function in_array {
  ARRAY=$2
  for e in ${ARRAY[*]}
  do
    if [[ "$e" == "$1" ]]
    then
      return 0
    fi
  done
  return 1
}

allowedInstances=("t2.nano" "t2.micro" "t2.small" "t2.medium")

if in_array $1 "${allowedInstances[*]}"
  then
    echo "$1 instance is allowed"
  else
    echo "$1 instance is not allowed"
    exit 1
fi
