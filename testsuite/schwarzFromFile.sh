#!/bin/sh

MPIRUN=`which mpirun`
CURDIR="$( cd "$( dirname "$0" )" && pwd )"
ROOTDIR=${CURDIR}/../
WORKDIR=${ROOTDIR}/build

# Check Makefile or Cmake usage.
if [[ ! -d "${ROOTDIR}/.git" && ! -d "${ROOTDIR}/CMakeFiles" ]]; then
    echo "Wrong ROOTDIR variable!"
    exit 1
fi

# CMake usage, redefine working directory.
if [ ! -d "${ROOTDIR}/.git" ]; then
    WORKDIR=${ROOTDIR}
fi

EXDIR=${WORKDIR}/examples
DATDIR=${WORKDIR}/examples/data

if [ ! -d "${WORKDIR}" ]; then
    echo "-- bash copy files to build dir."
    mkdir -p ${EXDIR}
    mkdir -p ${DATDIR}
    cp -r ${ROOTDIR}/examples ${WORKDIR}/examples
fi

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
