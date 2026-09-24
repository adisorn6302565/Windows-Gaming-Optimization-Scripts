@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปิดการใช้งาน V-Sync...
echo.
echo [หมายเหตุ] สคริปต์นี้ตั้งค่าสำหรับ NVIDIA GPU
echo สำหรับ AMD หรือ Intel โปรดใช้แอปพลิเคชันควบคุมของผู้ผลิต
echo.

REM ตั้งค่าสำหรับ NVIDIA - ปิด V-Sync
REM V-Sync จำกัด FPS ตาม Refresh Rate ของจอภาพ
REM การปิดช่วยลด Input Lag แต่อาจทำให้เกิด Screen Tearing

reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\NVTweak" /v VSync /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด V-Sync สำหรับ NVIDIA เรียบร้อยแล้ว
    echo [คำแนะนำ] ตั้งค่า V-Sync ในเกมแต่ละเกมตามความต้องการ
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือไม่ได้ติดตั้ง NVIDIA GPU
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
