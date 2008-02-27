@echo off
SETLOCAL
SET LUA_PATH=.\src\?.lua
FOR %%I IN (%1) DO SET BASE=%%~nI
lua51 test\compile.lua %1 > %base%.il
ilasm /quiet /nologo /dll %base%.il
peverify %base%.dll
ENDLOCAL