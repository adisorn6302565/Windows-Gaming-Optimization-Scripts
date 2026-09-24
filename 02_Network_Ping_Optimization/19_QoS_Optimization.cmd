@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน


echo กำลังปรับแต่ง Quality of Service (QoS)...
echo.

REM ตั้งค่า NonBestEffortLimit เป็น 0 เพื่อปิดการสงวนแบนด์วิดท์ของ QoS
REM ตามค่าเริ่มต้น Windows สงวนแบนด์วิดท์ 20% สำหรับ QoS
REM การตั้งค่าเป็น 0 จะให้โปรแกรมใช้แบนด์วิดท์เต็มที่

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1

REM ตั้งค่า MaxOutstandingSends
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxOutstandingSends /t REG_DWORD /d 65535 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับแต่ง Quality of Service เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo ⚠️ ต้องรีสตาร์ทเครื่องเพื่อให้การเปลี่ยนแปลงมีผล
echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
