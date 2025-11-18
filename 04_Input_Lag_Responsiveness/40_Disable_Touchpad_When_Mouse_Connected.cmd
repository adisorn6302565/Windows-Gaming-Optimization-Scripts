@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปิดการใช้งาน Touchpad เมื่อต่อเมาส์...
echo.

REM ปิด Touchpad เมื่อต่อเมาส์
REM ป้องกันการสัมผัส Touchpad โดยไม่ตั้งใจขณะเล่นเกม

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v LeaveOnWithMouse /t REG_DWORD /d 0 /f >nul 2>&1

REM ปิด Touchpad Status
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า Touchpad เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
