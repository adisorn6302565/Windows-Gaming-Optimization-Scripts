@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังล้างไฟล์ Temp อัตโนมัติเมื่อปิดเครื่อง...
echo.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0013 /t REG_DWORD /d 2 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่าล้างไฟล์ Temp เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
