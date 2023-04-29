
function(check_git_repo)
    file(RELATIVE_PATH component_path "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    if(NOT "/${component_path}//" MATCHES "/[^/]*${BENCHMARK}[^/]*/")
        return()
    endif()

    set(repo_list "${git_repo_list}")
    foreach(repo1 ${ARGN})
        if(NOT " '${repo_list}' " MATCHES " '${repo1}' ")
            set(repo_list "${repo_list}'${repo1}' ")
        endif()
    endforeach()
    set(git_repo_list "${repo_list}" PARENT_SCOPE)
endfunction()

function(check_license name license_text)
    file(RELATIVE_PATH component_path "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    if(NOT "/${component_path}//" MATCHES "/[^/]*${BENCHMARK}[^/]*/")
        return()
    endif()

    if (NOT ";${license_list}" MATCHES ";${name}:")
        set(license_list "${license_list};${name}:${license_text}" PARENT_SCOPE)
    endif()
endfunction()

function(add_component_build type name)
    set(component ${name} PARENT_SCOPE)

    file(RELATIVE_PATH component_path "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    if(NOT "/${component_path}//" MATCHES "/[^/]*${BENCHMARK}[^/]*/")
        return()
    elseif(BENCHMARK)
        message("${green}INFO:${reset} Enabled ${component_path}: ${name}")
    endif()

    set(license_reqs "")
    set(sut_reqs "")
    set(req_mode "LICENSE")
    foreach(arg1 ${ARGN})
        if(arg1 STREQUAL "LICENSE")
            set(req_mode "LICENSE")
        elseif(arg1 STREQUAL "SUT")
            set(req_mode "SUT")
        else()
            if(req_mode STREQUAL "LICENSE")
                foreach(item ${license_list})
                    if((item MATCHES "^${arg1}:") AND (NOT ACCEPT_LICENSE STREQUAL "ALL") AND (NOT " ${ACCEPT_LICENSE} " MATCHES " ${arg1} "))
                        set(license_reqs "${license_reqs} '${item}'")
                    endif()
                endforeach()
            elseif(req_mode STREQUAL "SUT")
                set(sut_reqs "${sut_reqs};${arg1}")
            endif()
        endif()
    endforeach()

    string(TOUPPER "${BACKEND}_SUT" sut_var)
    set(sut_r "")
    set(sut_d "")
    foreach(sut1 ${sut_reqs})
        if(sut1)
            if(sut1 MATCHES "^-")
                if(" ${${sut_var}} " MATCHES " ${sut1} ")
                    set(sut_r "${sut_r} ${sut1}")
                else()
                    string(REGEX REPLACE "^-" "" sut1 "${sut1}")
                    set(sut_d "${sut_d};${sut1}")
                endif()
            elseif(" ${${sut_var}} " MATCHES " ${sut1} ")
                set(sut_r "${sut_r} ${sut1}")
            endif()
        endif()
    endforeach()

    if(NOT sut_r)
        string(STRIP "${${sut_var}}" sut_r)
        foreach(sut1 ${sut_d})
            string(REPLACE " ${sut1} " " " sut_r " ${sut_r} ")
        endforeach()
    endif()

    string(STRIP "${sut_r}" sut_r)
    string(REPLACE " " ";" sut_reqs "${sut_r}")
    set(sut_reqs "${sut_reqs}" PARENT_SCOPE)
    string(REPLACE "\n" "\\n" license_reqs "${license_reqs}")

    string(TOUPPER ${type} typeu)
    add_custom_target(bom_${name} COMMAND bash -c "echo BOM of ${PLATFORM}/${name}:" COMMAND bash -c "PLATFORM=${PLATFORM} IMAGEARCH=${IMAGEARCH} ${typeu}=${name} BACKEND=${BACKEND} RELEASE=${RELEASE} REGISTRY=${REGISTRY} PROJECTROOT='${PROJECT_SOURCE_DIR}' ${sut_var}='${sut_r}' SOURCEROOT='${CMAKE_CURRENT_SOURCE_DIR}' BUILDROOT='${CMAKE_BINARY_DIR}' '${CMAKE_CURRENT_SOURCE_DIR}/build.sh' --bom" VERBATIM)
    add_dependencies(bom bom_${name})

    add_custom_target(build_${name} ALL COMMAND bash -c "'${PROJECT_SOURCE_DIR}/script/check-license.sh' '${CMAKE_CURRENT_BINARY_DIR}/.check-license' ${license_reqs} && '${PROJECT_SOURCE_DIR}/script/check-git-repo.sh' '${CMAKE_CURRENT_BINARY_DIR}/.check-git' ${git_repo_list} && ${BACKEND_ENVS} PLATFORM=${PLATFORM} IMAGEARCH=${IMAGEARCH} ${typeu}=${name} BACKEND=${BACKEND} RELEASE=${RELEASE} REGISTRY=${REGISTRY} PROJECTROOT='${PROJECT_SOURCE_DIR}' BUILDROOT='${CMAKE_BINARY_DIR}' ${sut_var}='${sut_r}' SOURCEROOT='${CMAKE_CURRENT_SOURCE_DIR}' '${CMAKE_CURRENT_SOURCE_DIR}/build.sh' ${BUILDSH_OPTIONS} && ('${CMAKE_SOURCE_DIR}/script/code-check.sh' '${CMAKE_CURRENT_SOURCE_DIR}' 2> /dev/null || true)" VERBATIM)
    set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES "${CMAKE_CURRENT_BINARY_DIR}/.check-license" "${CMAKE_CURRENT_BINARY_DIR}/.check-git")
    if(COMMAND add_backend_dependencies)
        add_backend_dependencies(${type} ${name})
    endif()

    if(NOT IMAGEARCH STREQUAL "linux/amd64")
        add_dependencies(build_${name} build_march)
    endif()
    execute_process(COMMAND bash -c "ln -s -r -f '${PROJECT_SOURCE_DIR}'/script/benchmark/*.sh ." WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
    if(COMMAND add_backend_tools)
        add_backend_tools(${type})
    endif()
endfunction()

function(add_component_testcase type component name)
    file(RELATIVE_PATH component_path "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    if((NOT "/${component_path}//" MATCHES "/[^/]*${BENCHMARK}[^/]*/") OR (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/validate.sh"))
        return()
    endif()

    function(add_testcase_1 name backend)
        string(REPLACE ";" " " argstr "${ARGN}")

        string(TOUPPER ${type} typeu)
      	add_test(NAME test_${name} COMMAND bash -c "rm -rf $CTESTSH_PREFIX''logs-${name} && mkdir -p $CTESTSH_PREFIX''logs-${name} && cd $CTESTSH_PREFIX''logs-${name} && ${BACKEND_ENVS} TESTCASE=test_${name} PLATFORM=${PLATFORM} IMAGEARCH=${IMAGEARCH} ${typeu}=${component} RELEASE=${RELEASE} REGISTRY=${REGISTRY} BENCHMARK='${BENCHMARK}' TIMEOUT=${TIMEOUT} ${backend} PROJECTROOT='${PROJECT_SOURCE_DIR}' SOURCEROOT='${CMAKE_CURRENT_SOURCE_DIR}' BUILDROOT='${CMAKE_BINARY_DIR}' REGISTRY_AUTH=${REGISTRY_AUTH} '${CMAKE_CURRENT_SOURCE_DIR}/validate.sh' ${argstr}" WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

        set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES "${CMAKE_CURRENT_BINARY_DIR}/logs-${name}")
    endfunction()

    if(COMMAND add_backend_testcase)
        add_backend_testcase(${type} ${component} ${name} ${ARGN})
    else()
        add_testcase_1(${name} "BACKEND=${BACKEND}" ${ARGN})
    endif()
endfunction()

