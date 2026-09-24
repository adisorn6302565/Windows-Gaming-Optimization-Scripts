@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังเพิ่มข้อยกเว้นของ Antivirus...
echo.
echo [หมายเหตุ] แก้ไขเส้นทางโฟลเดอร์เกมตามที่คุณต้องการ
echo.

powershell -Command "Add-MpPreference -ExclusionPath 'C:\Games'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath 'D:\Games'" >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เพิ่มข้อยกเว้นของ Antivirus เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
