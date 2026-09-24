@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปิดการใช้งาน Receive Segment Coalescing (RSC)...
echo.

REM ปิด RSC เพื่อลดความล่าช้าในการประมวลผล Network Packets
REM RSC รวม Packets หลายๆ แพ็กเก็ต ซึ่งอาจเพิ่ม Latency
REM การปิดช่วยลด Ping สำหรับเกมออนไลน์

netsh int tcp set global rsc=disabled >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Receive Segment Coalescing เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
