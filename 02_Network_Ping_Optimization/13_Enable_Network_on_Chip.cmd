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

echo กำลังเปิดใช้งาน Network-on-Chip (NOC)...
echo.

REM เปิดใช้งาน NOC สำหรับ Network Adapter
REM NOC ช่วยเพิ่มประสิทธิภาพการสื่อสารระหว่าง Network และ CPU
REM หมายเหตุ: ไม่ใช่ทุก Network Adapter ที่รองรับฟีเจอร์นี้

REM ตั้งค่าสำหรับ Network Adapter Class
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "*NetworkDirect" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "*NetworkDirect" /t REG_SZ /d "1" /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เปิดใช้งาน Network-on-Chip เรียบร้อยแล้ว
    echo [หมายเหตุ] ถ้า Network Adapter ไม่รองรับ การตั้งค่าจะไม่มีผล
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
