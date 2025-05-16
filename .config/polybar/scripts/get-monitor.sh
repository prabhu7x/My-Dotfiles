#!/bin/bash

xrandr | awk '/ connected/ {print $1; exit}'
