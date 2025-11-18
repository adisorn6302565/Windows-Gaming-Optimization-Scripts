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

echo กำลังเปิดใช้งาน Resizable BAR...
echo.
echo [หมายเหตุ] ฟีเจอร์นี้ต้องการ:
echo - BIOS/UEFI ที่รองรับ Resizable BAR
echo - GPU ที่รองรับ (NVIDIA RTX 3000+, AMD RX 6000+)
echo - เปิดใช้งานใน BIOS ก่อน
echo.

REM เปิดใช้งาน Resizable BAR ใน Windows
REM Resizable BAR อนุญาตให้ CPU เข้าถึง VRAM ของ GPU ได้เต็มจำนวน
REM ช่วยเพิ่มประสิทธิภาพในบางเกม

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v EnableResizableBar /t REG_DWORD /d 1 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เปิดใช้งาน Resizable BAR เรียบร้อยแล้ว
    echo [คำเตือน] ถ้าระบบไม่รองรับ อาจทำให้เกิดปัญหา
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
