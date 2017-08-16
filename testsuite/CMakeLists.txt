set(SH_TESTS
    schwarz_cpp_custom_op.sh
    schwarzFromFile.sh   
    )

foreach( fd ${SH_TESTS})
    file(COPY 
        ${CMAKE_SOURCE_DIR}/testsuite/${fd}
        DESTINATION ${CMAKE_BINARY_DIR}/testsuite/
        FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
        )
endforeach()



hpddm_add_test(
    TARGETS test_schwarz_cpp_custom_op
    COMMAND ${CMAKE_BINARY_DIR}/testsuite/schwarz_cpp_custom_op.sh
    DEPENDS schwarz_cpp )

hpddm_add_test(
    TARGETS test_schwarzFromFile
    COMMAND ${CMAKE_BINARY_DIR}/testsuite/schwarzFromFile.sh
    DEPENDS schwarzFromFile_cpp )
