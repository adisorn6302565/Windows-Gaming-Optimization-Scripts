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

echo กำลังปรับค่า Time-to-Live (TTL) เริ่มต้น...
echo.

REM ตั้งค่า Default TTL เป็น 64 (ค่ามาตรฐานสำหรับ IPv4)
REM TTL กำหนดจำนวน Hops สูงสุดที่แพ็กเก็ตสามารถผ่านได้
REM ค่า 64 เหมาะสมสำหรับการใช้งานทั่วไปและเกมออนไลน์

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 64 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับค่า Default TTL เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
