# Add an HPDDM application.
macro(hpddm_custom_target)
    set(options OPTIONAL)
    set(onearg  TARGETS TYPE DESTINATION)
    set(multargs SOURCES META DEPENDS LINKS)
    cmake_parse_arguments( parsed "${options}" "${onearg}" "${multargs}" ${ARGN})

    foreach(target ${parsed_TARGETS})
        if("${parsed_TYPE}" STREQUAL "shared")
            add_library( ${target} SHARED ${parsed_SOURCES} )
        elseif("${parsed_TYPE}" STREQUAL "static" )
            add_library( ${target} STATIC ${parsed_SOURCES} )
        elseif("${parsed_TYPE}" STREQUAL "module" ) # both
            add_library( ${target} MODULE ${parsed_SOURCES} )
        else()
            add_executable( ${target} ${parsed_SOURCES} )
        endif()
        target_include_directories( ${target} PRIVATE ${CMAKE_SOURCE_DIR}/include
            PRIVATE ${CMAKE_SOURCE_DIR}/interface )
        target_link_libraries( ${target} ${HPDDM_DEPEND_LIBRARIES} )

        if(NOT "${parsed_DEPENDS}" STREQUAL "")
            add_dependencies(${target} ${parsed_DEPENDS})
        endif()
        if(NOT "${parsed_LINKS}" STREQUAL "")
            target_link_libraries(${target} ${parsed_LINKS})
        endif()

        if(MPI_COMPILE_FLAGS)
            set_target_properties(${target} PROPERTIES
                COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
        endif()
    
        if(MPI_LINK_FLAGS)
            set_target_properties(${target} PROPERTIES
                LINK_FLAGS "${MPI_LINK_FLAGS}")
        endif()

        if(NOT "${parsed_DESTINATION}" STREQUAL "")
            install( TARGETS ${target}
                DESTINATION ${parsed_DESTINATION} )
        endif()
    endforeach()

    # Add to additional targets.
    foreach(meta ${parsed_META})
        list(APPEND HPDDM_META_${meta} ${parsed_TARGETS})
        list(APPEND HPDDM_META_TARGETS "${meta}")
        list(REMOVE_DUPLICATES HPDDM_META_TARGETS)
        # Set scope.
        set( HPDDM_META_${meta} ${HPDDM_META_${meta}} PARENT_SCOPE)
        set( HPDDM_META_TARGETS ${HPDDM_META_TARGETS} PARENT_SCOPE)
    endforeach()
endmacro()

# Add an HPDDM test using ctest.
macro(hpddm_add_test)
    set(options OPTIONAL)
    set(onearg  TARGETS )
    set(multargs COMMAND DEPENDS LABELS)
    cmake_parse_arguments( parsed "${options}" "${onearg}" "${multargs}" ${ARGN})

    add_custom_target( ${parsed_TARGETS}
        DEPENDS ${parsed_DEPENDS} )
    add_test( NAME ${parsed_TARGETS} 
        COMMAND ${parsed_COMMAND} )
    set_property( TEST ${parsed_TARGETS} PROPERTY LABELS ${parsed_LABEL})

    # Add to additional targets.
    list(APPEND HPDDM_META_testsuite ${parsed_TARGETS})
    list(APPEND HPDDM_META_TARGETS "testsuite")
    list(REMOVE_DUPLICATES HPDDM_META_TARGETS)
    # Set scope.
    #set( HPDDM_META_testsuite ${HPDDM_META_testsuite} PARENT_SCOPE)
    #set( HPDDM_META_TARGETS ${HPDDM_META_TARGETS} PARENT_SCOPE)
endmacro()

# Generate additionnal meta targets.
macro( hpddm_generate_meta )
    message( STATUS "Generating following meta targets: ${HPDDM_META_TARGETS}")
    foreach( meta ${HPDDM_META_TARGETS} )
        add_custom_target( ${meta} DEPENDS ${HPDDM_META_${meta}} )
    endforeach()
endmacro()
