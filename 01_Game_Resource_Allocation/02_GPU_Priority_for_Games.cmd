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

echo กำลังตั้งค่าความสำคัญของ GPU สำหรับเกม...
echo.

REM ตั้งค่า GPU Priority สูงสุดสำหรับโหมด AC Power
REM เพิ่มประสิทธิภาพ GPU ให้ทำงานเต็มประสิทธิภาพ
for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set SCHEME=%%a
powercfg /setacvalueindex %SCHEME% SUB_VIDEO VIDEOCONLOCK 0 >nul 2>&1
powercfg /setactive %SCHEME% >nul 2>&1

REM ตั้งค่า Graphics Performance Preference
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrLevel /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า GPU Priority สำหรับเกมเรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้บางส่วน
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
