#!/bin/bash

EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` {arg}"
  exit 1
fi

version=$1

filename_tex="edge-detection-review-v$version.tex"
filename_aux="edge-detection-review-v$version.aux"

pdflatex $filename_tex
bibtex $filename_aux
pdflatex $filename_tex
pdflatex $filename_tex


rm *.aux
rm *.bbl
rm *.blg
rm *.log
rm *.out
