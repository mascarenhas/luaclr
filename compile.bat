@echo off
lua51 test\compile.lua %1.lua > %1.il
ilasm /quiet /nologo /dll %1.il
peverify %1.dll