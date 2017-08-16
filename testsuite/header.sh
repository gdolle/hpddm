CURDIR="$( cd "$( dirname "$0" )" && pwd )"
MPIRUN=`which mpirun`
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
