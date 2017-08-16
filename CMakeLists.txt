################################################################################
# -*- coding: utf-8 -*-
#
#   This file is part of HPDDM.
#
#   Author(s): Guillaume Dolle <gdolle@unistra.fr>
#        Date: 2017-08-14
#
#   Copyright (C) 2015      Eidgenössische Technische Hochschule Zürich
#                 2016-     Centre National de la Recherche Scientifique
#
#   HPDDM is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Lesser General Public License as published
#   by the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   HPDDM is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with HPDDM.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

cmake_minimum_required (VERSION 3.6.0)
project (hpddm)

if("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")
   message(SEND_ERROR "In-source builds are not allowed.")
endif("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")
set(VERBOSE $ENV{VERBOSE} CACHE INTERNAL "")

enable_language (Fortran)
enable_testing()

find_package(MPI REQUIRED)
find_package(OpenMP)
find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)
find_package(SCALAPACK REQUIRED)
find_package(MUMPS REQUIRED)
find_package(SCOTCH COMPONENTS ESMUMPS REQUIRED)
find_package(METIS REQUIRED)
find_package(ARPACK REQUIRED)
find_package(Hypre)
find_package(PythonLibs REQUIRED)

include_directories(${CMAKE_SOURCE_DIR}/include/)
include_directories(${CMAKE_SOURCE_DIR}/interface/)

# Depends include directories.
include_directories( ${MPI_INCLUDE_PATH} )
include_directories( ${SCALAPACK_INCDIR} )
include_directories( ${MUMPS_INCLUDE_DIRS} )
include_directories( ${SCOTCH_INCLUDE_DIRS} )
if( HYPRE_FOUND )
    include_directories( ${HYPRE_INCLUDE_DIRS} )
endif()
include_directories( ${METIS_INCLUDE_DIRS} )
include_directories( ${ARPACK_INCLUDE_DIR} )
include_directories( ${PYTHON_INCLUDE_DIRS} )
# Fortran specific.
include_directories( ${MPI_Fortran_INCLUDE_PATH} )

# HPDDM depend libraries.
set(HPDDM_DEPEND_LIBRARIES "" CACHE STRING "" )
list( APPEND HPDDM_DEPEND_LIBRARIES ${MPI_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${OPENMP_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${BLAS_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${LAPACK_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${SCALAPACK_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${SCOTCH_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${METIS_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${MUMPS_LIBRARIES} )
list( APPEND HPDDM_DEPEND_LIBRARIES ${ARPACK_LIBRARIES} )
if( HYPRE_FOUND )
    list( APPEND HPDDM_DEPEND_LIBRARIES ${HYPRE_LIBRARIES} )
endif()

if( VERBOSE )
    message( STATUS "HPDDM_DEPEND_LIBRARIES: ${HPDDM_DEPEND_LIBRARIES}")
endif()

# HPDDM solver options.
set(HPDDM_SOLVER "MUMPS" CACHE STRING "")
set(HPDDM_SUBSOLVER "MUMPS" CACHE STRING "" )
set(HPDDM_EIGENSOLVER "ARPACK" CACHE STRING "")

# HPDDM flags.
set(HPDDM_FLAGS "" CACHE STRING "" )
set(HPDDM_FLAGS "${HPDDM_FLAGS} -DHPDDM_NUMBERING=\\'C\\'")
set(HPDDM_FLAGS "${HPDDM_FLAGS} -DD${HPDDM_SOLVER}")
set(HPDDM_FLAGS "${HPDDM_FLAGS} -D${HPDDM_SUBSOLVER}SUB")
set(HPDDM_FLAGS "${HPDDM_FLAGS} -DMU_${HPDDM_EIGENSOLVER}")

# C++ specific.
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${HPDDM_FLAGS}")
if(OPENMP_FOUND)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OPENMP_FLAGS}")
endif()

# C specific.
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${HPDDM_FLAGS}")
if(OPENMP_FOUND)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OPENMP_FLAGS}")
endif()

# Fortran specific.
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${HPDDM_FLAGS}")
if(OPENMP_FOUND)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${OPENMP_FLAGS}")
endif()
set(Fortran_MODULE_DIRECTORY "./interface/")

set(THREADS_PREFER_PTHREAD_FLAG ON)

include(cmake/hpddm.macros.cmake)
include(cmake/hpddm.install.cmake)

add_subdirectory(benchmark)
add_subdirectory(examples)
add_subdirectory(interface)
add_subdirectory(testsuite)

hpddm_generate_meta()
