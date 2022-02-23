@echo off
setlocal

mkdir build
nasm -f win64 src\%1.s -o build\%1.obj && gcc -m64 build\%1.obj -s -o build\%1.exe && build\%1.exe