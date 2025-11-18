@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปิดการใช้งาน Print Spooler Service...
echo.
echo [หมายเหตุ] ถ้าคุณใช้เครื่องพิมพ์ ไม่ควรปิด Service นี้
echo.

sc config "Spooler" start= disabled >nul 2>&1
sc stop "Spooler" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Print Spooler Service เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
