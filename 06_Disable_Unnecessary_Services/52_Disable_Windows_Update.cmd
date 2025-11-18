@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปิดการใช้งาน Windows Update Service (ชั่วคราว)...
echo.
echo ⚠️ คำเตือน: การปิด Windows Update อาจทำให้ระบบไม่ได้รับการอัปเดตความปลอดภัย
echo แนะนำให้เปิดใหม่หลังจากเล่นเกมเสร็จ
echo.

sc config "wuauserv" start= disabled >nul 2>&1
sc stop "wuauserv" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Windows Update Service เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
