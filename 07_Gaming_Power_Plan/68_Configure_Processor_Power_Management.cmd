@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปรับการตั้งค่า Processor Power Management...
echo.

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set SCHEME=%%a
powercfg /setacvalueindex %SCHEME% SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setacvalueindex %SCHEME% SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setactive %SCHEME% >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับ Processor Power Management เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
