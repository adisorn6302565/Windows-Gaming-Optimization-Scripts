@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปรับค่า Timer Resolution ของระบบ...
echo.

REM ตั้งค่า Processor Performance
REM ให้ CPU ทำงานที่ 100% เพื่อลด Latency

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set SCHEME=%%a

powercfg /setacvalueindex %SCHEME% SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setacvalueindex %SCHEME% SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1

REM Apply Power Scheme
powercfg /setactive %SCHEME% >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับค่า Timer Resolution เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
