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

MPIRUN=`which mpirun`
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10 -hpddm_krylov_method bgmres
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10 ---hpddm_krylov_method bgmres
