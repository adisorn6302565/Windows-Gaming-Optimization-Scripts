@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"
title KANAO Gaming Optimization Scripts

:categories
cls
echo ==========================================================
echo    KANAO Gaming Optimization Scripts
echo ==========================================================
echo  แนะนำ: เลือก 00 สำรองข้อมูลก่อนใช้งานครั้งแรก
echo.
set i=0
for /f "delims=" %%d in ('dir /b /ad /on ^| findstr /r "^[0-9][0-9]_"') do (
    set /a i+=1
    set "CAT!i!=%%d"
    echo   [!i!] %%d
)
echo   [Q] ออก
echo.
set "sel="
set /p sel=เลือกหมวด:
if /i "%sel%"=="Q" exit /b
if not defined CAT%sel% goto categories
set "CAT=!CAT%sel%!"

:scripts
cls
echo ==== %CAT% ====
echo.
set j=0
for %%f in ("%CAT%\*.cmd") do (
    set /a j+=1
    set "S!j!=%%f"
    echo   [!j!] %%~nf
)
echo   [A] รันทั้งหมดในหมวดนี้
echo   [B] กลับ
echo.
set "pick="
set /p pick=เลือกสคริปต์:
if /i "%pick%"=="B" goto categories
if /i "%pick%"=="A" (
    for %%f in ("%CAT%\*.cmd") do (
        echo.
        echo ^>^>^> %%~nf
        echo. | call "%%f"
    )
    echo.
    echo เสร็จทั้งหมวด ^(บางค่าต้องรีสตาร์ท^)
    pause
    goto scripts
)
if not defined S%pick% goto scripts
call "!S%pick%!"
goto scripts
