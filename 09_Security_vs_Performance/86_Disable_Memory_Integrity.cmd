@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    pause
    exit /b 1
)

echo กำลังปิดการใช้งาน Memory Integrity (Core Isolation)...
echo.
echo ⚠️ ความเสี่ยงสูง: การปิดฟีเจอร์นี้อาจทำให้ระบบปลอดภัยน้อยลง
echo.

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Memory Integrity เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
