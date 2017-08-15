# C interface.
hpddm_custom_target(
    TARGETS hpddm_c
    SOURCES hpddm_c.cpp
    TYPE module
    DESTINATION ./lib/
    META libs interfaces c_interface
)

# Fortran interface.
hpddm_custom_target(
    TARGETS hpddm_fortran
    SOURCES hpddm_fortran.cpp
    TYPE module
    DESTINATION ./lib/
    META libs interfaces fortran_interface
)

# Python interface
hpddm_custom_target(
    TARGETS hpddm_python
    SOURCES hpddm_python.cpp
    TYPE module
    DESTINATION ./lib/
    META libs interfaces python_interface
)
