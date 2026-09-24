@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังตั้งค่า Power Plan ของ GPU เป็น Maximum Performance...
echo.

REM ค้นหา Active Power Scheme
for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set SCHEME=%%a

REM ตั้งค่า Graphics Power Settings
REM SUB_VIDEO = Video subgroup
REM VIDEOIDLE = Video timeout
powercfg /setacvalueindex %SCHEME% SUB_VIDEO VIDEOIDLE 0 >nul 2>&1

REM ตั้งค่า GPU Preference เป็น Maximum Performance
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrLevel /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 10 /f >nul 2>&1

REM Apply Power Scheme
powercfg /setactive %SCHEME% >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า GPU Power Plan เป็น Maximum Performance เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
