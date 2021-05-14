#!/bin/bash
if [ $# -eq 0 ] 
then
    rm ./output/tree/*.txt
    rm ./output/matrix/*.txt
    rm ./debug*.txt
elif [ "$1" = "swipl" ]; 
then
    printf 'deleting /output/tree|matrix|debug/*.txt ...\n'
    rm ./output/tree/*.txt
    rm ./output/matrix/*.txt
    rm ./debug*.txt
    printf 'entering swipl ...\n'
    swipl
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