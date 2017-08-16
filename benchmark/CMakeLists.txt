# local_solver benchmark.
hpddm_custom_target(
    TARGETS local_solver
    SOURCES local_solver.cpp 
    DESTINATION ./bin
    META benchmarks)

# local_solver_eigensolver benchmark.
#hpddm_custom_target(
#    TARGETS local_eigensolver
#    SOURCES local_eigensolver.cpp
#    DESTINATION ./bin
#    META benchmarks)
