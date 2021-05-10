#!/bin/bash
if [ $# -eq 0 ] 
then
    rm ./output/tree/*.txt
    rm ./output/matrix/*.txt
elif [ "$1" = "tree" ]; 
then
    rm ./output/tree/*.txt
elif [ "$1" = "matrix" ]; 
then
    rm ./output/matrix/*.txt
else
    printf './clean_output.sh           -> delete .txt files under /output/tree/ and /output/matrix/\n'
    printf './clean_output.sh matrix    -> delete .txt files under /output/matrix/\n'
    printf './clean_output.sh tree      -> delete .txt files under /output/tree/\n'
fi