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

echo กำลังปรับค่า Latency Tolerance ของ USB Port...
echo.

REM ลด USB Latency Tolerance
REM ช่วยเพิ่มความเร็วในการตอบสนองของอุปกรณ์ USB (เมาส์ คีย์บอร์ด)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}\0000" /v IdleEnable /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับค่า USB Latency Tolerance เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
