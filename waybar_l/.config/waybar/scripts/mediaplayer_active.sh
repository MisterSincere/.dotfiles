#!/bin/env bash

spotify_running=$(pgrep spotify)

if [ -n "$spotify_running" ]; then
	exit 0;
else
	exit 1;
fi
