@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปิดการใช้งาน Xbox Services...
echo.

sc config "XboxGipSvc" start= disabled >nul 2>&1
sc stop "XboxGipSvc" >nul 2>&1

sc config "XboxNetApiSvc" start= disabled >nul 2>&1
sc stop "XboxNetApiSvc" >nul 2>&1

sc config "XblAuthManager" start= disabled >nul 2>&1
sc stop "XblAuthManager" >nul 2>&1

sc config "XblGameSave" start= disabled >nul 2>&1
sc stop "XblGameSave" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Xbox Services เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้บางส่วน
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
