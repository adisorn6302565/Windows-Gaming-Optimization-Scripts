@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปิดการใช้งานฟีเจอร์ประหยัดพลังงานของ GPU...
echo.

REM ค้นหา Active Power Scheme
for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set SCHEME=%%a

REM ปิดการประหยัดพลังงานของ GPU
REM ให้ GPU ทำงานเต็มประสิทธิภาพตลอดเวลา

REM ตั้งค่า PCI Express Link State Power Management
powercfg /setacvalueindex %SCHEME% SUB_PCIEXPRESS LINKSTATE 0 >nul 2>&1
powercfg /setdcvalueindex %SCHEME% SUB_PCIEXPRESS LINKSTATE 0 >nul 2>&1

REM Apply Power Scheme
powercfg /setactive %SCHEME% >nul 2>&1

REM ปิด GPU Power Saving ใน Registry
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v CsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิดฟีเจอร์ประหยัดพลังงานของ GPU เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
