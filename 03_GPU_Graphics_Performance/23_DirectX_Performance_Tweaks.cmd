@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปรับปรุงประสิทธิภาพของ DirectX...
echo.

REM ปิดการใช้งาน Software Vertex Processing
REM บังคับให้ใช้ Hardware Acceleration สำหรับ DirectX
reg add "HKEY_CURRENT_USER\Software\Microsoft\DirectX" /v UseSoftwareVP /t REG_DWORD /d 0 /f >nul 2>&1

REM เปิดใช้งาน DirectDraw Hardware Acceleration
reg add "HKEY_CURRENT_USER\Software\Microsoft\DirectDraw" /v EmulationOnly /t REG_DWORD /d 0 /f >nul 2>&1

REM ตั้งค่า Direct3D Acceleration
reg add "HKEY_CURRENT_USER\Software\Microsoft\Direct3D" /v DisableDXMaximizedWindowedMode /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับปรุงประสิทธิภาพ DirectX เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
