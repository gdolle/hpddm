file(COPY ${CMAKE_SOURCE_DIR}/testsuite/schwarzFromFile.sh
    DESTINATION ${CMAKE_BINARY_DIR}/testsuite/
    FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
    )

hpddm_add_test(
    TARGETS test_schwarz_cpp_custom_op
    COMMAND
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10 -hpddm_krylov_method bgmres
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10 ---hpddm_krylov_method bgmres
    DEPENDS schwarz_cpp )

hpddm_add_test(
    TARGETS test_schwarzFromFile
    COMMAND ${CMAKE_BINARY_DIR}/testsuite/schwarzFromFile.sh
    DEPENDS schwarzFromFile_cpp )
