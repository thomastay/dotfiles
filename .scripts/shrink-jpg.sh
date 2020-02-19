#!/bin/bash
convert -sampling-factor 4:2:0 -strip -quality 30% $1 ${1%.*}-small.jpg
