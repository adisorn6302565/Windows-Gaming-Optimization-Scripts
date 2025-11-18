@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังลบ Shortcut Arrow ออกจากไอคอน...
echo.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%systemroot%\System32\shell32.dll,-50" /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ลบ Shortcut Arrow เรียบร้อยแล้ว
    echo [หมายเหตุ] ต้องรีสตาร์ท Explorer หรือเครื่องเพื่อให้เห็นผล
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
