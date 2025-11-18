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

echo กำลังเพิ่มขนาดของ Master File Table (MFT)...
echo.

REM เพิ่มขนาด MFT Zone เป็น 4 (50% ของดิสก์)
REM ช่วยลดการกระจายตัวของไฟล์
REM เหมาะสำหรับดิสก์ที่มีไฟล์จำนวนมาก

fsutil behavior set MftZoneReservation 4 >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เพิ่มขนาด MFT Zone เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
