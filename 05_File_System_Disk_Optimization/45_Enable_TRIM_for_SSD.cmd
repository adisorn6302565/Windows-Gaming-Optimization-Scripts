@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังเปิดใช้งาน TRIM สำหรับ SSD...
echo.

REM เปิดใช้งาน TRIM สำหรับ SSD
REM TRIM ช่วยให้ SSD รักษาประสิทธิภาพและอายุการใช้งาน
REM ค่า 0 = เปิดใช้งาน TRIM

fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เปิดใช้งาน TRIM สำหรับ SSD เรียบร้อยแล้ว
    echo [หมายเหตุ] TRIM ช่วยรักษาประสิทธิภาพ SSD ในระยะยาว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
