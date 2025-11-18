@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปรับปรุงการตอบสนองของคีย์บอร์ด...
echo.

REM ตั้งค่า Keyboard Delay เป็น 0 (ไม่มีความล่าช้า)
REM ช่วยให้คีย์บอร์ดตอบสนองทันทีเมื่อกดค้าง

reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f >nul 2>&1

REM ตั้งค่า Keyboard Speed เป็นสูงสุด (31)
REM ควบคุมความเร็วในการทำซ้ำเมื่อกดปุ่มค้าง
reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับปรุงการตอบสนองของคีย์บอร์ดเรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
