install( 
    DIRECTORY ${CMAKE_SOURCE_DIR}/include/
    DESTINATION ./include/hpddm
)
install(
    FILES ${CMAKE_SOURCE_DIR}/interface/HPDDM.h
    ${CMAKE_SOURCE_DIR}/interface/HPDDM.f90
    ${CMAKE_SOURCE_DIR}/interface/hpddm.py
    DESTINATION ./include/hpddm/interface
)
