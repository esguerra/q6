#!/bin/bash
ffmpeg -framerate 2/1 -i frame_%04d.png -c:v libx264 -r 30 -pix_fmt yuv420p out.mp4

