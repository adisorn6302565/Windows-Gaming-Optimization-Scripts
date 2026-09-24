@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

REM คืนค่า Registry จากชุดสำรองล่าสุดที่สร้างด้วย 00_Backup_Registry_and_Restore_Point.cmd
set "ROOT=%ProgramData%\KANAO-Gaming-Scripts"
set "LATEST="
for /f "delims=" %%d in ('dir /b /ad /o-n "%ROOT%\backup-*" 2^>nul') do if not defined LATEST set "LATEST=%%d"

if not defined LATEST (
    echo ไม่พบไฟล์สำรองใน %ROOT%
    echo ใช้ System Restore แทน: Win+R ^> rstrui
    pause
    exit /b 1
)

echo จะคืนค่าจาก: %ROOT%\%LATEST%
choice /c YN /m "ยืนยัน"
if errorlevel 2 exit /b

for %%f in ("%ROOT%\%LATEST%\*.reg") do (
    echo   import %%~nxf
    reg import "%%f" >nul 2>&1
)

echo.
echo [เสร็จ] หมายเหตุ: ค่าที่สคริปต์ "เพิ่มใหม่" จะยังอยู่ ถ้ายังมีปัญหาให้ใช้ System Restore (rstrui)
echo กรุณารีสตาร์ทเครื่อง
pause
