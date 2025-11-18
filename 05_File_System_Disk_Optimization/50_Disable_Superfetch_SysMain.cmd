@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    echo กดคลิกขวาที่ไฟล์แล้วเลือก "Run as administrator"
    pause
    exit /b 1
)

echo กำลังปิดการใช้งาน Superfetch/SysMain...
echo.
echo [หมายเหตุ] Superfetch ช่วยโหลดแอปที่ใช้บ่อยเข้า RAM
echo สำหรับ SSD อาจไม่จำเป็นและใช้ทรัพยากรโดยไม่จำเป็น
echo.

REM ปิด SysMain (Superfetch) Service
sc config "SysMain" start= disabled >nul 2>&1
sc stop "SysMain" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Superfetch/SysMain เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
