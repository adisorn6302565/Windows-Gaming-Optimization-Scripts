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

echo กำลังปิดการใช้งาน Indexing...
echo.
echo [หมายเหตุ] การปิด Indexing อาจทำให้การค้นหาไฟล์ช้าลง
echo แต่ช่วยเพิ่มประสิทธิภาพดิสก์และลดการใช้ CPU
echo.

REM ปิด Windows Search Indexing
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f >nul 2>&1

REM ปิด Indexing บน SSD
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexingLowDiskSpaceMB /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Indexing เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
