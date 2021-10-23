cmake_minimum_required(VERSION 3.10)
project(CSmtp)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

file(GLOB_RECURSE LIBSRC csmtp/*)
file(GLOB_RECURSE EXESRC sender/*)

if(MSVC)
  include_directories(${OPENSSL}/include)
  link_directories(${OPENSSL}/lib)
  add_compile_options(/w14996)
endif()

add_library(csmtp STATIC ${LIBSRC})
if(MSVC)
  target_link_libraries(csmtp libssl libcrypto)
else()
  target_link_libraries(csmtp ssl crypto)
endif()

add_executable(mail_sender ${EXESRC})
target_link_libraries(mail_sender csmtp)
