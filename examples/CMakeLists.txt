file(COPY ${CMAKE_SOURCE_DIR}/examples/data/
    DESTINATION ${CMAKE_BINARY_DIR}/examples/data
    )

# C++ example.
hpddm_custom_target(
    TARGETS schwarz_cpp 
    SOURCES schwarz.cpp generate.cpp schwarz.hpp
    DESTINATION ./bin
    META cpp)

hpddm_custom_target(
    TARGETS driver
    SOURCES driver.cpp
    DESTINATION ./bin
    META cpp)

hpddm_custom_target(
    TARGETS schwarzFromFile_cpp
    SOURCES schwarz.cpp generateFromFile.cpp  
    DESTINATION ./bin
    META cpp)

# C example.
hpddm_custom_target( 
    TARGETS schwarz_c 
    SOURCES schwarz.c generate.c schwarz.h
    DEPENDS c_interface
    DESTINATION ./bin
    LINKS hpddm_c
    META c)

# Fortran example.
hpddm_custom_target( 
    TARGETS custom_operator 
    SOURCES custom_operator.f90 ../interface/HPDDM.f90
    DEPENDS c_interface
    DESTINATION ./bin
    LINKS hpddm_fortran
    META fortran)
