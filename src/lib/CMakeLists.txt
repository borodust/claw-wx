cmake_minimum_required(VERSION 3.25)
project(wx.clawed)

set(LIBRARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/wx)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD 17)

# setup rpath
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH "$\{ORIGIN\}")

if (MSVC)
    set(TARGET_TRIPLE x86_64-w64-mingw32)

    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(CMAKE_MSVC_RUNTIME_LIBRARY MultiThreadedDebugDLL)
    elseif ()
        set(CMAKE_MSVC_RUNTIME_LIBRARY MultiThreadedDLL)
    endif ()
else ()
    set(TARGET_TRIPLE x86_64-pc-linux-gnu)
endif ()

add_subdirectory("${LIBRARY_DIR}")
option(BUILD_STATIC_LIBS ON)
option(BUILD_SHARED_LIBS OFF)

#
# MAIN
#
set(TARGET wx.clawed)
set(ADAPTER "adapter.${TARGET_TRIPLE}.cxx")

add_library(${TARGET} SHARED ${ADAPTER})
set_source_files_properties(${ADAPTER} PROPERTIES LANGUAGE CXX)

target_include_directories(${TARGET}
        PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/../"
        PUBLIC "${LIBRARY_DIR}/include")

target_link_libraries(${TARGET}
        PRIVATE wxWidgets::wxWidgets)
