#!/usr/bin/env bash

# Check if hyprsunset is running using pgrep
pid=$(pgrep -x hyprsunset)

if [ -z "$pid" ]; then
  # If not running, start hyprsunset with the specified temperature
  hyprsunset -t 4500 &
  echo "hyprsunset started with temperature 5700"
else
  # If running, kill hyprsunset
  kill "$pid"
  echo "hyprsunset stopped"
fi
