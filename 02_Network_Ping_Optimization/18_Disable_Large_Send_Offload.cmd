@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปิดการใช้งาน Large Send Offload (LSO)...
echo.

REM ปิด TCP Chimney Offload
REM Chimney Offload ย้ายการประมวลผล TCP ไปยัง Network Adapter
REM การปิดอาจช่วยลด Latency ในบางกรณี

netsh int tcp set global chimney=disabled >nul 2>&1

REM ปิด Task Offload ต่างๆ
netsh int tcp set global taskoffload=disabled >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Large Send Offload เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
