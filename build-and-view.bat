@echo off
echo Building PreTeXt book...
if not exist ".venv\Scripts\python.exe" (
    echo Missing project environment. Run: py -3.14 -m venv .venv
    exit /b 1
)

".venv\Scripts\python.exe" -m pretext build web

if %errorlevel% neq 0 (
    echo Build failed!
    exit /b %errorlevel%
)

echo.
echo Copying custom STACK JS file...
copy /Y "assets\pretext\js\pretext-stack\stackapicalls.js" "output\web\_static\pretext\js\pretext-stack\stackapicalls.js" >nul

if %errorlevel% neq 0 (
    echo Failed to copy custom JS file!
    exit /b %errorlevel%
)

echo Custom stackapicalls.js deployed successfully!
echo.

echo Launching browser...
".venv\Scripts\python.exe" -m pretext view web
