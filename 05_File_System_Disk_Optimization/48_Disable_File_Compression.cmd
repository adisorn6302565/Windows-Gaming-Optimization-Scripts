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

echo กำลังปิดการบีบอัดไฟล์...
echo.

REM ปิดการบีบอัด NTFS Compression
REM การบีบอัดใช้ CPU และลดความเร็วในการอ่านเขียน
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableCompression /t REG_DWORD /d 1 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิดการบีบอัดไฟล์เรียบร้อยแล้ว
    echo [หมายเหตุ] ไฟล์ที่บีบอัดอยู่แล้วจะยังคงบีบอัดอยู่
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
