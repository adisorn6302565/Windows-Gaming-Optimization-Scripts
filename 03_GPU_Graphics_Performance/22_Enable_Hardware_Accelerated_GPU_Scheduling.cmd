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

echo กำลังเปิดใช้งาน Hardware-Accelerated GPU Scheduling...
echo.
echo [หมายเหตุ] ฟีเจอร์นี้ต้องการ Windows 10 2004 ขึ้นไป และ GPU ที่รองรับ
echo.

REM เปิดใช้งาน Hardware-Accelerated GPU Scheduling
REM ช่วยลด Latency และเพิ่มประสิทธิภาพการทำงานของ GPU
REM ค่า 2 = เปิดใช้งาน

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เปิดใช้งาน Hardware-Accelerated GPU Scheduling เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือ GPU ไม่รองรับ
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
