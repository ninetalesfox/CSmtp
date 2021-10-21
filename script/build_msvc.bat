cd %~dp0..

set BUILD_TYPE=%1
set BUILD_BITS=%2
set BUILD_COMPILE=%3

rem script params: msvc.bat [BUILD_TYPE] [BUILD_COMPILE] [BUILD_BITS]
rem default value: BUILD_TYPE=Debug BUILD_COMPILE=VS2015 BUILD_BITS=x86

if "%BUILD_TYPE%"=="" (set BUILD_TYPE=Debug)
if "%BUILD_COMPILE%"=="" (set BUILD_COMPILE=VS2015)

if not "%BUILD_BITS%"=="x64" (set BUILD_BITS=x86)

if "%BUILD_COMPILE%"=="VS2015" (set BUILD_COMPILE=Visual Studio 14 2015)
if "%BUILD_COMPILE%"=="VS2017" (set BUILD_COMPILE=Visual Studio 15 2017)
if "%BUILD_COMPILE%"=="VS2019" (set BUILD_COMPILE=Visual Studio 16 2019)

rem only VS2019 uses "BUILD_ARCH_ARG"
set BUILD_ARCH_ARG=
if "%BUILD_COMPILE%"=="Visual Studio 16 2019" (
if "%BUILD_BITS%"=="x64" (set BUILD_ARCH_ARG=-A x64) ^
else (set BUILD_ARCH_ARG=-A Win32)
) else (
if "%BUILD_BITS%"=="x64" (set BUILD_COMPILE=%BUILD_COMPILE% Win64)
)

mkdir build\solution
cd build\solution
cmake -G "%BUILD_COMPILE%" %BUILD_ARCH_ARG% ../../csmtp ^
-DOPENSSL=%~dp0..\csmtp-ref\openssl-1.1.1l\openssl-1.1\%BUILD_BITS%
cmake --build . --config %BUILD_TYPE% -j 8
cd ..\..

mkdir build\archive
cd build\archive
cd ..\..
