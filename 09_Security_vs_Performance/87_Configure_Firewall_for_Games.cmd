@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปรับแต่งการตั้งค่า Firewall...
echo.
echo [หมายเหตุ] แก้ไขเส้นทางไฟล์เกมตามที่คุณต้องการ
echo.

netsh advfirewall firewall add rule name="Allow Game" dir=in action=allow program="C:\Games\YourGame.exe" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เพิ่ม Firewall Rule เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือเส้นทางไม่ถูกต้อง
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
