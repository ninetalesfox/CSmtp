cd %~dp0..\csmtp-ref
powershell -executionpolicy remotesigned -file "%~dp0extract_open_source.ps1"
cd %~dp0..
