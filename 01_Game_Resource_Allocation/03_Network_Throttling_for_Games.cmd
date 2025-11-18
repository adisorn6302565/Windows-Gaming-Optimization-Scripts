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

echo กำลังจัดลำดับความสำคัญของ Network สำหรับเกม...
echo.

REM ตั้งค่า Auto Tuning Level เป็น Normal
REM ช่วยให้ระบบปรับแต่ง TCP Window Size อัตโนมัติ
netsh int tcp set global autotuninglevel=normal >nul 2>&1

REM เปิดใช้งาน Direct Cache Access
netsh int tcp set global dca=enabled >nul 2>&1

REM เปิดใช้งาน Network Direct Memory Access
netsh int tcp set global netdma=enabled >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า Network Priority สำหรับเกมเรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้บางส่วน
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
