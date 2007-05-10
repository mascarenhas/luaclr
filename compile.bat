@echo off
lua51 test\compile.lua %1 > fib.il
ilasm /dll fib.il
peverify /verbose fib.dll
