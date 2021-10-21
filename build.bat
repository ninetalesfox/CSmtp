echo on

cd %~dp0

set RUN_MODE=%1

set BUILD_TYPE=%2
set BUILD_BITS=%3
set BUILD_COMPILE=%4

if "%RUN_MODE%"=="" (set RUN_MODE=man)

if "%RUN_MODE%"=="extract" (call script\extract_open_source.bat)

if "%RUN_MODE%"=="msvc" (call script\build_msvc.bat  %BUILD_TYPE% %BUILD_BITS% %BUILD_COMPILE%)

rem run by default or double click
if "%RUN_MODE%"=="man" (call script\build_msvc.bat Debug x64 VS2015)

if "%RUN_MODE%"=="clean" (call script\clean.bat)
if "%RUN_MODE%"=="config" (call script\config.bat)

pause
