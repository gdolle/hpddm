hpddm_add_test(
    TARGETS schwarz_cpp_custom_op
    COMMAND
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examples/schwarz_cpp -hpddm_verbosity -hpddm_schwarz_method none -Nx 10 -Ny 10 -hpddm_krylov_method bgmres
    ${MPIEXEC} -np 1 ${CMAKE_BINARY_DIR}/examles/schwarz_cpp -symmetric_csr -hpddm_verbosity -hpddm_schwarz_method=none -Nx 10 -Ny 10 ---hpddm_krylov_method bgmres
    DEPENDS schwarz_cpp )
