cmake_minimum_required(VERSION 3.10)
project(CSmtpDemo)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(../build/archive/inc)
link_directories(../build/archive/lib)

add_executable(demo Main.cpp)
if(MSVC)
target_link_libraries(demo csmtp)
else()
target_link_libraries(demo csmtp ssl crypto)
endif()
