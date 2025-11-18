@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปรับแต่งการตั้งค่า Anti-Aliasing...
echo.
echo [หมายเหตุ] สคริปต์นี้ตั้งค่าสำหรับ NVIDIA GPU
echo.

REM ตั้งค่า Anti-Aliasing Mode
REM Anti-Aliasing ช่วยลดขอบหยักของวัตถุในเกม
REM ค่า 8 = 8x MSAA (คุณภาพสูง)

reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\OpenGL" /v AntialiasingSetting /t REG_DWORD /d 8 /f >nul 2>&1

REM ตั้งค่า Antialiasing Mode
reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\NVTweak" /v Antialiasing /t REG_DWORD /d 1 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า Anti-Aliasing เรียบร้อยแล้ว
    echo [หมายเหตุ] การตั้งค่า AA สูงจะใช้ทรัพยากร GPU มากขึ้น
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือไม่ได้ติดตั้ง NVIDIA GPU
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
