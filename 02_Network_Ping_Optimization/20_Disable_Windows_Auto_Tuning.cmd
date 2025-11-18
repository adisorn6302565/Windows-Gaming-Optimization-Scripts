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

echo กำลังปิดการใช้งาน Windows Auto-Tuning...
echo.

REM ปิด Auto-Tuning Level
REM Auto-Tuning ปรับ TCP Receive Window อัตโนมัติ
REM การปิดอาจช่วยให้ได้ Latency ที่คงที่มากขึ้น

netsh int tcp set global autotuninglevel=disabled >nul 2>&1

REM ตั้งค่าเพิ่มเติมสำหรับ TCP
netsh int tcp set heuristics disabled >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Windows Auto-Tuning เรียบร้อยแล้ว
    echo [หมายเหตุ] การปิด Auto-Tuning อาจลดความเร็ว Download แต่ลด Ping
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
