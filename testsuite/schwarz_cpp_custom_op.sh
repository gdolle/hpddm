#!/bin/sh

CURDIR="$( cd "$( dirname "$0" )" && pwd )"
# header set global variables.
source ${CURDIR}/header.sh

MPIRUN=`which mpirun`
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10 -hpddm_krylov_method bgmres
${MPIRUN} -np 1 ${WORKDIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10 ---hpddm_krylov_method bgmres
