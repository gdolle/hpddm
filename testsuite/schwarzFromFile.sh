#!/bin/sh

CURDIR="$( cd "$( dirname "$0" )" && pwd )"
# header set global variables.
source ${CURDIR}/header.hpp



if [ -f ${DATDIR}/mini.tar.gz ]; then
    cd ${WORKDIR}
    tar -xvf ${DATDIR}/mini.tar.gz -C ${DATDIR}; 
    for NP in 2 4; do 
        for OVERLAP in 1 3; do 
            CMD="${MPIRUN} -np ${NP} ${EXDIR}/schwarzFromFile_cpp
            -matrix_filename=${DATDIR}/mini.mtx
            -hpddm_verbosity 2 -overlap ${OVERLAP}"; 
            echo "${CMD}"; 
            ${CMD} || exit; 
        done
    done
else
    echo "$0: ${DATDIR}/mini.tar.gz not found!"
    exit 1
fi
