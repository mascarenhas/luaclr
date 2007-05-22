@echo off
lua51 test\compile.lua %1 > fib.il
ilasm /quiet /nologo /dll fib.il
