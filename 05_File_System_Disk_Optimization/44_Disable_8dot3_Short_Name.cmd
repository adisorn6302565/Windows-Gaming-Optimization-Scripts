@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปิดการสร้าง 8.3 Short Name...
echo.

REM ปิดการสร้าง 8.3 Short Name Creation
REM ช่วยเพิ่มความเร็วในการสร้างไฟล์
REM ลดขนาด MFT

fsutil behavior set Disable8dot3 1 >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิดการสร้าง 8.3 Short Name เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
